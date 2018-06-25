defmodule ExcommerceWeb.CategoryController do
  use ExcommerceWeb, :controller

  #alias Excommerce.SearchProduct
  alias Excommerce.Repo

  plug :get_root_categories

  def associated_products(conn, %{"category_id" => id}) do
    category =
      Excommerce.Query.Category.get!(Repo, id)
      |> Repo.preload([products: Excommerce.Query.Product.products_with_master_variant])

    products = category.products
    categories = Excommerce.Query.Category.with_associated_products(Repo)

    #search_changeset = SearchProduct.changeset(%Excommerce.SearchProduct{})
    #search_action = product_path(conn, :index)

    render conn, "products.html",
      categories: categories,
      products: products
      #search_action: search_action,
      #search_changeset: search_changeset
  end

  defp get_root_categories(conn, _params) do
    root_cat = Excommerce.Query.Category.get_root_cat(Repo)
    conn
    |> assign(:root_cat, root_cat)
  end
end
