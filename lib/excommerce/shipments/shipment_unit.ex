defmodule Excommerce.Shipments.ShipmentUnit do
  use Ecto.Schema
  import Ecto.Changeset

  alias Excommerce.Shipments.{ShipmentUnit, Shipment, ShippingMethod}
  alias Excommerce.Orders.{Order, LineItem}
  
  schema "shipment_units" do

    # associations

    belongs_to  :order, Order

    has_many :line_items, LineItem, on_delete: :nilify_all
    has_one  :shipment, Shipment, on_delete: :nilify_all

    # virtual fields
    field :proposed_shipments, {:array, :map}, virtual: true

    timestamps()
    
  end

  @required_fields ~w(order_id)a
  @optional_fields ~w()a

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """

  def changeset(shipment_unit, attrs \\ %{}) do
    shipment_unit
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def create_shipment_changeset(shipment_unit, attrs \\ %{}) do
    shipment_unit
    |> cast(params_with_shipping_cost(shipment_unit, attrs), [])
    |> validate_required([])
    |> cast_assoc(:shipment, required: true, with: &Shipment.create_changeset/2)
  end

  defp params_with_shipping_cost(_shipment_unit, %{"shipment" => %{"shipping_method_id" => ""}} = attrs), do: attrs

  defp params_with_shipping_cost(shipment_unit, %{"shipment" => %{"shipping_method_id" => shipping_method_id}} = attrs) do
    shipping_method = Excommerce.Repo.get(ShippingMethod, shipping_method_id)
    {:ok, shipping_cost} = ExcommerceWeb.ShippingCalculator.shipping_cost(shipping_method, shipment_unit)

    %{attrs | "shipment" => Map.merge(Map.get(attrs, "shipment"), %{"shipping_cost" => shipping_cost, "order_id" => shipment_unit.order_id})}
  end

  defp params_with_shipping_cost(_shipment_unit, attrs), do: attrs

end
