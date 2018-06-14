defmodule ExcommerceWeb.Admin.ProductView do
  use ExcommerceWeb, :view
  use Scrivener.HTML

  import Ecto.Query
  alias Excommerce.Catalog.{Product, ProductOptionType, OptionType, ProductCategory}
  alias Excommerce.Repo

  def link_to_product_option_types_fields do
    changeset = Product.changeset(%Product{product_option_types: [%ProductOptionType{}]}, %{})
    form = Phoenix.HTML.FormData.to_form(changeset, [])
    get_option_types = Repo.all(from o in OptionType, select: {o.name, o.id})
    fields = render_to_string(__MODULE__, "product_option_types.html", f: form, get_option_types: get_option_types)
    link "Add Option Type", to: "#", "data-template": fields, id: "add_product_option_type", class: "btn btn-success"
  end

  def link_to_product_category_fields(leaf_categories) do
    changeset = Product.changeset(%Product{product_categories: [%ProductCategory{}]}, %{})
    form = Phoenix.HTML.FormData.to_form(changeset, [])
    categories = leaf_categories
    fields = render_to_string(__MODULE__, "product_categories.html", f: form, categories: categories)
    link "Add Category", to: "#", "data-template": fields, id: "add_product_category", class: "btn btn-success"
  end

end
