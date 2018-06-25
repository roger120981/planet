defmodule Excommerce.Query.Shipment do
  use Excommerce.Query, schema: Excommerce.Shipments.Shipment

  def for_order(order) do
    from o in Excommerce.Shipments.Shipment,
      join: p in assoc(o, :shipment_unit),
      where: p.order_id == ^order.id
  end
end
