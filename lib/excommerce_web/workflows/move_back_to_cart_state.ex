defmodule ExcommerceWeb.Workflow.MoveBackToCartState do

  alias Ecto.Multi

  def run(repo, order), do: repo.transaction(steps(order))

  def steps(order) do
    Multi.new()
    |> Multi.delete_all(:delete_payment, Excommerce.Query.Payment.for_order(order))
    |> Multi.delete_all(:delete_tax_adjustments, Excommerce.Query.Adjustment.tax_adjustments_for_order(order))
    |> Multi.delete_all(:delete_shipment_adjustments, Excommerce.Query.Adjustment.shipment_adjustments_for_order(order))
    |> Multi.delete_all(:delete_shipment_units, Excommerce.Query.ShipmentUnit.for_order(order))
    |> Multi.delete_all(:delete_shipping_address, Excommerce.Query.OrderShippingAddress.for_order(order))
    |> Multi.delete_all(:delete_billing_address, Excommerce.Query.OrderBillingAddress.for_order(order))
    |> Multi.update(:update_state, Excommerce.Orders.Order.state_changeset(order, %{state: "cart"}))
  end

end
