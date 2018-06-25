defmodule Excommerce.Orders.LineItem do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Orders.{LineItem, Order}
  alias Excommerce.Catalog.Variant
  alias Excommerce.Shipments.ShipmentUnit

  schema "line_items" do
    belongs_to :variant, Variant
    belongs_to :order, Order
    belongs_to :shipment_unit, ShipmentUnit

    field :add_quantity, :integer, virtual: true # No defaults to avoid issues with being provided same value as default.
    field :unit_price, :decimal
    field :quantity, :integer, default: 0
    field :total, :decimal
    field :fullfilled, :boolean, default: true

    field :delete, :boolean, virtual: true
    
	timestamps()
    
  end

  def changeset(line_item, attrs \\ %{}) do
    line_item
    |> create_changeset(attrs)
    |> quantity_changeset(attrs)
  end

  def fullfillment_changeset(line_item, attrs \\ %{}) do
    line_item
    |> cast(attrs, [:fullfilled])
    |> validate_required([:fullfilled])
  end

  def create_changeset(line_item, attrs \\ %{}) do
    line_item
    |> cast(attrs, [:order_id, :unit_price])
    |> validate_required([:order_id, :unit_price])
    |> foreign_key_constraint(:order_id)
  end

  def quantity_changeset(line_item, attrs \\ %{}) do
    line_item
    |> cast(attrs, [:fullfilled, :add_quantity, :unit_price])
    |> validate_required([:add_quantity, :unit_price])
    |> validate_number(:add_quantity, greater_than: 0)
    |> add_to_existing_quantity
    |> quantity_update(attrs)
  end

  def direct_quantity_update_changeset(line_item, attrs \\ %{}) do
    line_item
    |> cast(attrs, [:delete, :quantity, :unit_price])
    |> validate_required([:quantity, :unit_price])
    |> quantity_update(attrs)
    |> set_delete_action
  end

  defp quantity_update(changeset, attrs) do
    changeset
    |> validate_number(:quantity, greater_than: 0)
    |> update_total_changeset(attrs)
  end

  defp update_total_changeset(struct, attrs) when attrs == %{}, do: struct
  defp update_total_changeset(struct, _attrs) do
    quantity       = get_field(struct, :quantity) |> Decimal.new
    unit_price     = get_field(struct, :unit_price)
    cost           = Decimal.mult(quantity, unit_price)
    # always based on the current price
    put_change(struct, :total, cost)
  end


  defp add_to_existing_quantity(%Ecto.Changeset{valid?: false} = changeset), do: changeset
  defp add_to_existing_quantity(changeset) do
    existing_quantity = get_field(changeset, :quantity)
    change_in_quantity = get_field(changeset, :add_quantity)
    put_change(changeset, :quantity, existing_quantity + change_in_quantity)
  end

  defp set_delete_action(changeset) do
    if get_change(changeset, :delete) do
      %{changeset| action: :delete}
    else
      changeset
    end
  end

end
