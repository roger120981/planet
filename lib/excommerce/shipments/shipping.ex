defmodule Excommerce.Shipments.Shipping do
  use Ecto.Schema
  import Ecto.Changeset

  alias Excommerce.Shipments.{Shipping, ShippingMethod}
  alias Excommerce.Orders.Order
  alias Excommerce.Adjustments.Adjustment

  schema "shippings" do
    belongs_to :order, Order
    belongs_to :shipping_method, ShippingMethod
    
	  has_one :adjustment, Adjustment
    field :shipping_state, :string, default: "shipment_created"

    timestamps()
    
  end

  #@shipping_states ~w(shipment_created pending shipped received return_initiated picked_up return_received)

  @required_fields ~w(shipping_method_id)a
  @optional_fields ~w()a

  def changeset(shipping, attrs \\ %{}) do
    shipping
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def applicable_shipping_changeset(shipping, attrs \\ %{}) do
    shipping
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:adjustment)
    |> foreign_key_constraint(:shipping_method_id)
  end

end
