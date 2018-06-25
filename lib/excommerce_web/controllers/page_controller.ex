defmodule ExcommerceWeb.PageController do
  use ExcommerceWeb, :controller

  plug :get_root_categories

  def index(conn, _params) do
    products = Excommerce.Query.Product.featured_products(Repo)
    categories = Excommerce.Query.Category.with_associated_products(Repo)

    render(conn, "index.html", products: products, categories: categories)
  end

  defp get_root_categories(conn, _params) do
    root_cat = Excommerce.Query.Category.get_root_cat(Repo)
    conn
    |> assign(:root_cat, root_cat)
  end

end
