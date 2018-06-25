defmodule ExcommerceWeb.Admin.UserView do
  use ExcommerceWeb, :view

  def render("pending_orders.json", %{orders: orders}) do
    Enum.map(orders, fn (%Excommerce.Orders.Order{} = order)->
      %{edit_cart_link: admin_cart_path(Shop.Endpoint, :edit, order),
        state: order.state,
        created_on: order.inserted_at,
        continue_checkout_link: admin_order_checkout_path(Excommerce.Endpoint, :checkout, order)}
    end)
  end

end
