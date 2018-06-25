defmodule Excommerce.Shipments.ShippingMethod do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Shipments.{Shipping, ShippingMethod}

  schema "shipping_methods" do
    field :name
    field :enabled, :boolean, default: false

    has_many :shippings, Shipping
    field :shipping_cost, :decimal, virtual: true, default: Decimal.new("0")

    timestamps()
    
  end

  @required_fields ~w(name)a
  @optional_fields ~w(enabled)a

  def changeset(shipping_method, attrs \\ %{}) do
    shipping_method
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

end
