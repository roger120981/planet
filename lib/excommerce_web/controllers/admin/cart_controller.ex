defmodule ExcommerceWeb.Admin.CartController do
  use ExcommerceWeb, :admin_controller

  def new(conn, _params) do
    users = Excommerce.Repo.all(Excommerce.Accounts.User)
    cart_changeset = Excommerce.Orders.Order.cart_changeset(%Excommerce.Orders.Order{}, %{})
    render(conn, "new.html", users: users, cart_changeset: cart_changeset)
  end

  # use guest checkout unless user id provided.
  def create(conn, %{"order" => %{"user_id" => ""}}) do
    order = Excommerce.Command.Order.create_empty_cart_for_guest!(Repo)
    conn
    |> redirect(to: admin_cart_path(conn, :edit, order))
  end

  def create(conn, %{"order" => %{"user_id" => user_id}}) do
    order = Excommerce.Command.Order.create_empty_cart_for_user!(Repo, user_id)
    conn
    |> redirect(to: admin_cart_path(conn, :edit, order))
  end

  def edit(conn, %{"id" => id}) do
    order = Repo.get!(Excommerce.Orders.Order, id)
    ExcommerceWeb.CheckoutManager.back(Repo, order, "cart")
    #{:ok, order} = Repo.get!(Excommerce.Orders.Order, id) |> ExcommerceWeb.CheckoutManager.back("cart")

    products  =
      Excommerce.Query.Product.all(Repo)
      |> Repo.preload([variants: [option_values: :option_type]])

    line_items =
      Excommerce.Query.LineItem.in_order(Repo, order)
      |> Repo.preload([variant: [:product, [option_values: :option_type]]])

    render(conn, "edit.html", order: order, products: products, line_items: line_items)
  end

end
