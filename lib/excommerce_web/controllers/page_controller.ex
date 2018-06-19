defmodule ExcommerceWeb.PageController do
  use ExcommerceWeb, :controller

  def index(conn, _params) do
    products = Excommerce.Query.Product.products_with_master_variant(Repo)
    categories = Excommerce.Query.Category.with_associated_products(Repo)

    render(conn, "index.html", products: products, categories: categories)
  end

end
