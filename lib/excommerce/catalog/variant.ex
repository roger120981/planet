defmodule Excommerce.Catalog.Variant do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias Excommerce.Catalog.{Product, VariantOptionValue, Variant}


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

  def create_variant_changeset(%Variant{} = variant, product, attrs \\ %{}) do
    changeset(variant, attrs)
    |> validate_discontinue_gt_available_on(product)
    |> put_change(:is_master, false)
    |> cast_attachments(attrs, [:image])
    #|> cast_assoc(:variant_images)
    |> cast_assoc(:variant_option_values, required: true, with: &VariantOptionValue.from_variant_changeset/2)
  end

  def update_variant_changeset(%Variant{} = variant, product, attrs \\ %{}) do
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
end
