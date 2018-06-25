defmodule ExcommerceWeb.ProductController do
  use ExcommerceWeb, :controller

  alias Excommerce.Query
  #alias Excommerce.SearchProduct
  alias Excommerce.Repo

  plug :get_root_categories

  def index(conn, _params) do
    categories = Query.Category.with_associated_products(Repo)
    products   = Query.Product.products_with_master_variant(Repo)
	
    render(conn, "index.html", products: products, categories: categories
      #search_changeset: SearchProduct.changeset(%SearchProduct{}, _params),
      #search_action: product_path(conn, :index)
    )
  end

  def show(conn, %{"id" => id}) do
    product = Query.Product.product_with_variants(Repo, id)
    render(conn, "show.html", product: product)
  end

  defp get_root_categories(conn, _params) do
    root_cat = Query.Category.get_root_cat(Repo)

    conn
    |> assign(:root_cat, root_cat)

  end

end
