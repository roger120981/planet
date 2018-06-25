defmodule Excommerce.Query.OrderShippingAddress do
  use Excommerce.Query, schema: Excommerce.Orders.OrderShippingAddress

  def for_order(order) do
    from o in Excommerce.Orders.OrderShippingAddress, where: o.order_id == ^order.id
  end

end