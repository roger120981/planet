defmodule Excommerce.Query.Payment do
  use Excommerce.Query, schema: Excommerce.Payments.Payment

  def for_order(%Excommerce.Orders.Order{id: order_id}) do
    from p in Excommerce.Payments.Payment,
    where: p.order_id == ^order_id
  end

end
