defmodule Excommerce.Shipments.Shipment do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Shipments.{Shipment, ShippingMethod, ShipmentUnit}
  alias Excommerce.Adjustments.Adjustment

  schema "shipments" do
    belongs_to :shipping_method, ShippingMethod
    belongs_to :shipment_unit, ShipmentUnit
    has_one    :adjustment, Adjustment

    timestamps()
  end

  @required_fields ~w(shipping_method_id)a
  @optional_fields ~w()a

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(shipment, attrs \\ %{}) do
    shipment
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def create_changeset(shipment, attrs \\ %{}) do
    shipment
    |> cast(params_with_adjustment(shipment, attrs), @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:adjustment)
  end

  defp params_with_adjustment(_shipment, attrs) do
    Map.put_new(attrs, "adjustment", %{"amount" => attrs["shipping_cost"], "order_id" => attrs["order_id"]})
  end

end
