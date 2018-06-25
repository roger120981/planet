defmodule Excommerce.Orders.OrderBillingAddress do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Orders.{Order, OrderBillingAddress}
  alias Excommerce.Addresses.Address

  schema "order_billing_addresses" do
    belongs_to :order, Order
    belongs_to :address, Address

    timestamps()
    
  end

  @required_fields ~w()
  @optional_fields  ~w(order_id)
  def changeset(order_billing_address, attrs \\ %{}) do
    order_billing_address
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:address, required: true)
  end
end
