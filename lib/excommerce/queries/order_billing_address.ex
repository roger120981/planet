defmodule Excommerce.Query.OrderBillingAddress do
  use Excommerce.Query, schema: Excommerce.Orders.OrderBillingAddress

  def for_order(order) do
    from o in Excommerce.Orders.OrderBillingAddress, where: o.order_id == ^order.id
  end

end
