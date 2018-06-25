defmodule Excommerce.Adjustments.Adjustment do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Adjustments.Adjustment
  alias Excommerce.Orders.Order
  alias Excommerce.Shipments.Shipment
  alias Excommerce.Taxation.Tax
  

  schema "adjustments" do
    belongs_to :shipment, Shipment
    belongs_to :tax,      Tax
    belongs_to :order,    Order

    field :amount, :decimal

    timestamps()
    
  end

  @required_fields ~w(amount)a
  @optional_fields ~w(shipment_id tax_id order_id)a

  def changeset(adjustment, attrs \\ %{}) do
    adjustment
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

end
