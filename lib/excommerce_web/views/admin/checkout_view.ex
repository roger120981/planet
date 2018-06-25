defmodule ExcommerceWeb.Admin.CheckoutView do
  use ExcommerceWeb, :view

  alias Excommerce.Repo
  alias ExcommerceWeb.CheckoutManager
  import Ecto.Query

  def country_names_and_ids do
    [{"--Select Country--", ""} | Repo.all(from c in Excommerce.Addresses.Country, select: {c.name, c.id})]
  end

  def state_names_and_ids do
    [{"--Select State--", ""} | Repo.all(from c in Excommerce.Addresses.State, select: {c.name, c.id})]
  end

  def adjustment_row(%Excommerce.Adjustments.Adjustment{shipment_id: shipment_id} = adjustment) when not is_nil(shipment_id) do
    content_tag :tr do
      [content_tag :td do
        to_string(adjustment.amount)
      end,
      content_tag :td do
        "shipping: #{adjustment.shipment.shipping_method.name}"
      end]
    end
  end

  def adjustment_row(%Excommerce.Adjustments.Adjustment{tax_id: tax_id} = adjustment) when not is_nil(tax_id) do
    content_tag :tr do
      [content_tag :td do
        to_string(adjustment.amount)
      end,
      content_tag :td do
        "tax: #{adjustment.tax.name}"
      end]
    end
  end

  def braintree_client_token do
    ExcommerceWeb.Gateway.Braintree.client_token
  end

  def next_step(%Excommerce.Orders.Order{state: state, confirmation_status: true} = order) do
    next_state = CheckoutManager.next_state(order)
    # cannot move forward therefore must be in confirmed state.
    if next_state == state do
      "confirmed.html"
    else
      "#{next_state}.form.html"
    end
  end

  def next_step(%Excommerce.Orders.Order{confirmation_status: false}) do
    "cancelled.html"
  end

  def error_in_payment_method?(changeset, payment_method_id) do
    (!changeset.valid?) && changeset.params["payment"]["payment_method_id"] == to_string(payment_method_id)
  end

  def back_link(conn, %Excommerce.Orders.Order{state: "cart"} = order) do
    link "Back", to: admin_cart_path(conn, :edit, order), class: "btn btn-xs"
  end

  def back_link(_conn, %Excommerce.Orders.Order{state: "confirmation"} = _order) do
    ""
  end

  def back_link(conn, %Excommerce.Orders.Order{} = order) do
    link "Back", to: admin_order_checkout_path(conn, :back, order), method: "put", class: "btn btn-xs"
  end

  def shipment_details(%Excommerce.Shipments.ShipmentUnit{} = shipment_unit) do
    Enum.reduce(shipment_unit.line_items, "", fn (line_item, acc) ->
      acc <> line_item.variant.product.name <> ","
    end)
  end

  def shipping_method_selection(data, id), do: shipping_method_selection(data.proposed_shipping_methods[id])

  def shipping_method_selection(proposed_shipments) do
    Enum.map(proposed_shipments, &({&1.shipping_method_name <> " (+#{&1.shipping_cost})", &1.shipping_method_id}))
  end

  def has_shipping_method?(data, shipment_unit_id) do
    not is_nil(data.proposed_shipping_methods[shipment_unit_id] )
  end

  def payment_methods_available?(%{applicable_payment_methods: []}),
    do: false

  def payment_methods_available?(%{}),
    do: true

end
