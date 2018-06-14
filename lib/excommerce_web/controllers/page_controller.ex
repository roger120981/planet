defmodule ExcommerceWeb.PageController do
  use ExcommerceWeb, :controller

  alias Excommerce.Themer

  plug :put_layout, false
  plug :put_view, false
  plug ExcommerceWeb.Plug.Settings

  def index(conn, _params) do
    products = Excommerce.Query.Product.products_with_master_variant(Repo)
    do_render(conn, 200, "index", products: products)
  end

  defp do_render(conn, status, template, assigns \\ []) do
    body = Themer.render(conn, template, assigns)

    conn
    |> put_resp_header("Content-Type", "text/html")
    |> send_resp(status, body)
  end
end
