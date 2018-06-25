defmodule Excommerce.Orders.OrderShippingAddress do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Orders.{Order, OrderShippingAddress}
  alias Excommerce.Addresses.Address

  schema "order_shipping_addresses" do
    belongs_to :order, Order
    belongs_to :address, Address

    timestamps()
    
  end

  @required_fields ~w()
  @optional_fields ~w(order_id)
  def changeset(order_shipping_address, attrs \\ %{}) do
    order_shipping_address
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:address, required: true)
  end

end
