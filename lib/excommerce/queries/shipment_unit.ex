defmodule Excommerce.Query.ShipmentUnit do
  use Excommerce.Query, schema: Excommerce.Shipments.ShipmentUnit

  def for_order(order) do
    from o in Excommerce.Shipments.ShipmentUnit, where: o.order_id == ^order.id
  end

end
