defmodule Excommerce.Query.Adjustment do
  use Excommerce.Query, schema: Excommerce.Adjustments.Adjustment

  def for_order(%Excommerce.Orders.Order{id: order_id}) do
    from p in Excommerce.Adjustments.Adjustment,
    where: p.order_id == ^order_id
  end

  def for_order(repo, order), do: repo.all(for_order order)

  def tax_adjustments_for_order(order) do
    from o in for_order(order), where: not(is_nil(o.tax_id))
  end

  def shipment_adjustments_for_order(order) do
    from o in for_order(order), where: not(is_nil(o.shipment_id))
  end
end
