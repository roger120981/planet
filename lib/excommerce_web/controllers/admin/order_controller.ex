defmodule ExcommerceWeb.Admin.OrderController do
  use ExcommerceWeb, :admin_controller

  alias Excommerce.Orders.Order
  alias Excommerce.Accounts.User
  alias Excommerce.Catalog.Product
  #alias Excommerce.SearchOrder

  import Ecto.Query


  def index(conn, _params) do
    orders = Repo.all(from o in Order, order_by: o.id) |> Repo.preload([:user])
    render(conn, "index.html", orders: orders,
      payment_methods: Repo.all(from p in Excommerce.Payments.PaymentMethod, select: {p.name, p.id}),
      shipping_methods: Repo.all(from p in Excommerce.Shipments.ShippingMethod, select: {p.name, p.id})
    )
  end

  def show(conn, %{"id" => id}) do
    order =
      Repo.get(Order, id)
    if order do
      order = order
              |> Repo.preload([line_items: [variant: [:product, [option_values: :option_type]]]])
              |> Repo.preload([shipments: [:shipping_method, :adjustment, shipment_unit: [line_items: [variant: [:product, [option_values: :option_type]]]]]])
              |> Repo.preload([adjustments: [:tax, :shipment]])
              |> Repo.preload([payment: [:payment_method]])
      render(conn, "show.html", order: order)
    else
      conn
        |> put_flash(:info, "Order Not found with id #{id}")
        |> redirect(to: admin_order_path(conn, :index))
        |> halt()
    end
  end

  def edit(conn, %{"id" => id}) do
    order = Repo.get(Order, id)
    changeset = Order.link_to_user_changeset(order)
    users = Repo.all(from u in User, select: {u.email, u.id})
    render(conn, "edit.html", users: users, order: order, changeset: changeset)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Repo.get(Order, id)
    changeset = Order.link_to_user_changeset(order, order_params)
    case Repo.update changeset do
      {:ok, _} -> conn |> put_flash(:info, "order updated successfully") |> redirect(to: admin_order_path(conn, :index))
      {:error, changeset} ->
        users = Repo.all(from u in User, select: {u.email, u.id})
        conn
        |> put_flash(:error, "failed to update the order, please see below for errors")
        |> render("edit.html", users: users, order: order, changeset: changeset)
    end
  end

  def cart(conn, _params) do
    # create a blank cart, maybe add it to conn and plug it later on
    order = Order.cart_changeset(%Order{}, %{}) |> Repo.insert!
    # order = Repo.get(Order, 1)
    products  =
      Product
      |> Repo.all
      |> Repo.preload([variants: [option_values: :option_type]])

    line_items =
      Excommerce.Query.LineItem.in_order(Repo, order)
      |> Repo.preload([:product])
    render(conn, "new.html", order: order, products: products, line_items: line_items)
  end
end
