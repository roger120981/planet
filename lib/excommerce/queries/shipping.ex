defmodule Excommerce.Query.Shipping do
  use Excommerce.Query, schema: Excommerce.Shipments.Shipping

  def for_order(%Excommerce.Orders.Order{id: order_id}) do
    from p in Excommerce.Shipments.Shipping,
    where: p.order_id == ^order_id
  end

  def for_order(repo, order), do: repo.all(for_order(order))

end
