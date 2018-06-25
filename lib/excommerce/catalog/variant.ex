defmodule Excommerce.Catalog.Variant do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias Excommerce.Catalog.{Product, VariantOptionValue, Variant}
  alias Excommerce.Orders.LineItem

  schema "variants" do
    field :cost_currency, :string
    field :cost_price, :decimal
    field :depth, :decimal
    field :discontinue_on, :date
    field :height, :decimal
    field :image, ExcommerceWeb.VariantImage.Type
    field :is_master, :boolean, default: false
    field :sku, :string
    field :weight, :decimal
    field :width, :decimal

    field :total_quantity, :integer, default: 0
    field :add_count, :integer, virtual: true

    field :bought_quantity, :integer, default: 0
    field :buy_count, :integer, virtual: true

    field :restock_count, :integer, virtual: true

    belongs_to :product, Product

    #has_many :variant_images, Excommerce.Catalog.Image
    has_many :variant_option_values, VariantOptionValue, on_delete: :delete_all, on_replace: :delete
    has_many :option_values, through: [:variant_option_values, :option_value]

    has_many :line_items, LineItem

    timestamps()
  end

  @doc false
  def changeset(variant, attrs) do
    variant
    |> cast(attrs, [:is_master, :sku, :weight, :height, :width, :depth, :discontinue_on, :cost_price, :cost_currency])
    |> validate_required([:is_master, :discontinue_on, :cost_price])
    |> Excommerce.Validations.Date.validate_not_past_date(:discontinue_on)
    |> validate_number(:add_count, greater_than: 0)
    |> update_total_quantity
  end

  def create_master_changeset(variant, attr) do
    variant
    |> cast(attr, [:cost_price, :add_count, :discontinue_on, :image])
    |> validate_required([:cost_price])
    |> update_total_quantity
    |> put_change(:is_master, true)
    |> validate_number(:add_count, greater_than: 0)
    #|> cast_assoc(:variant_images)
    |> cast_attachments(attr, [:image])
  end

  def update_master_changeset(variant, attr) do
    variant
    |> cast(attr, [:cost_price, :add_count, :discontinue_on, :image])
    |> cast_attachments(attr, [:image])
    |> validate_required([:cost_price, :discontinue_on])
    |> Excommerce.Validations.Date.validate_not_past_date(:discontinue_on)
    #|> validate_discontinue_gt_available_on
    |> update_total_quantity
    |> put_change(:is_master, true)
    |> validate_number(:add_count, greater_than: 0)
    |> check_is_master_changed
    #|> cast_assoc(:variant_images)
  end

  def create_variant_changeset(variant, product, attrs \\ %{}) do
    changeset(variant, attrs)
    |> validate_discontinue_gt_available_on(product)
    |> put_change(:is_master, false)
    |> cast_attachments(attrs, [:image])
    #|> cast_assoc(:variant_images)
    |> cast_assoc(:variant_option_values, required: true, with: &VariantOptionValue.from_variant_changeset/2)
  end

  def update_variant_changeset(variant, product, attrs \\ %{}) do
    changeset(variant, attrs)
    |> validate_discontinue_gt_available_on(product)
    |> validate_not_master
    |> cast_attachments(attrs, [:image])
    #|> cast_assoc(:variant_images)
    |> cast_assoc(:variant_option_values, required: true, with: &VariantOptionValue.from_variant_changeset/2)
  end

  defp validate_not_master(changeset) do
    if changeset.data.is_master do
      add_error(changeset, :is_master, "can't be updated")
      |> add_error(:base, "Please go to Product Edit Page to update master variant")
    else
      changeset
    end
  end

  defp update_total_quantity(variant) do
    quantity_to_add = variant.changes[:add_count]
    if quantity_to_add do
      put_change(variant, :total_quantity, variant.data.total_quantity + quantity_to_add)
    else
      variant
    end
  end

  defp check_is_master_changed(changeset) do
    if get_change(changeset, :is_master) do
      add_error(changeset, :is_master, "appears to assign another variant as master variant")
      |> add_error(:base, "Please check whether your Master Variant is deleted :(")
    else
      changeset
    end
  end

  defp validate_discontinue_gt_available_on(changeset, product) do
    changeset
      |> Excommerce.Validations.Date.validate_gt_date(:discontinue_on, product.available_on)
  end

  @required_fields ~w(buy_count)a
  @optional_fields ~w()a
  def buy_changeset(variant, attrs \\ %{}) do
    variant
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:buy_count, greater_than: 0)
    |> increment_bought_quantity
  end

  def restocking_changeset(variant, attrs) do
    variant
    |> cast(attrs, [:restock_count])
    |> validate_required([:restock_coun])
    |> validate_number(:restock_count, greater_than: 0)
    |> decrement_bought_quantity
  end

  defp update_total_quantity(variant) do
    quantity_to_add = variant.changes[:add_count]
    if quantity_to_add do
      put_change(variant, :total_quantity, variant.data.total_quantity + quantity_to_add)
    else
      variant
    end
  end

  defp increment_bought_quantity(variant) do
    quantity_to_add = variant.changes[:buy_count]
    if quantity_to_add do
      put_change(variant, :bought_quantity, (variant.data.bought_quantity || 0) + quantity_to_add)
    else
      variant
    end
  end

  defp decrement_bought_quantity(variant) do
    quantity_to_subtract = variant.changes[:restock_count]
    if quantity_to_subtract do
      put_change(variant, :bought_quantity, (variant.data.bought_quantity || 0) - quantity_to_subtract)
    else
      variant
    end
  end

  def available_quantity(%Variant{total_quantity: total_quantity, bought_quantity: bought_quantity}) when is_nil(bought_quantity) do
    total_quantity
  end

  def available_quantity(%Variant{total_quantity: total_quantity, bought_quantity: bought_quantity}) do
    total_quantity - bought_quantity
  end

  def display_name(variant) do
    product = variant.product
    "#{product.name}(#{variant.sku})"
  end

  def sufficient_quantity_available?(variant, requested_quantity) do
    available_quantity(variant) >= requested_quantity
  end

  def discontinued?(variant) do
    discontinue_on = variant.discontinue_on
    if discontinue_on do
      case Date.compare(discontinue_on, Date.utc_today) do
        :lt -> true
        _   -> false
      end
    else
      false
    end
  end

  def availability_status(variant, requested_quantity \\ 0) do
    cond do
      discontinued?(variant) ->
        :discontinued
      not sufficient_quantity_available?(variant, requested_quantity) ->
        available = available_quantity(variant)
        if available > 0 do
          {:insufficient_quantity, available}
        else
          :out_of_stock
        end
      true ->
        :ok
    end
  end
end
