defmodule ExcommerceWeb.Admin.ProductController do
  use ExcommerceWeb, :admin_controller
  
  alias Excommerce.Catalog.{Product, Tag, OptionType}
  alias Excommerce.SearchProduct

  plug :scrub_params, "product" when action in [:create, :update]
  plug :load_categories_and_option_types when action in [:create, :new, :edit, :update]
  plug :load_tags when action in [:create, :new, :edit, :update]

  def index(conn, %{"search_product" => search_params} = _params) do
    products = Repo.all(Excommerce.Search.filter_product(search_params)) |> Repo.preload(:master)
    render(conn, "index.html", products: products,
      search_changeset: SearchProduct.changeset(%SearchProduct{}, search_params),
      search_action: admin_product_path(conn, :index))
  end

  def index(conn, _params) do
    products = Excommerce.Catalog.list_products() |> Repo.preload(:master)
    render(conn, "index.html", products: products,
      search_changeset: SearchProduct.changeset(%SearchProduct{}, %{}),
      search_action: admin_product_path(conn, :index))
  end

  def new(conn, params) do
    changeset = Product.changeset(%Product{available_on: Date.utc_today()}, params)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"product"=>product_params}) do
    case Excommerce.Catalog.insert_product(product_params) do
      {:ok, _product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: admin_product_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Repo.get_by(Product, permalink: id) |> Repo.preload([:master])
    render(conn, "show.html", product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = Repo.get_by(Product, permalink: id) |> Repo.preload([:master, :option_types, :tags, :product_categories])
    chageset = Product.changeset(product, %{})
    render(conn, "edit.html", product: product, changeset: chageset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Repo.get_by(Product, permalink: id) |> Repo.preload([:master, :option_types, :tags, :product_categories])
    changeset = Product.update_changeset(product, product_params)

    case Repo.update(changeset) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: admin_product_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Repo.get_by(Product, permalink: id)
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: admin_product_path(conn, :index))
  end

  defp load_tags(conn, _params) do
    tags = Repo.all(from strct in Tag, select: {strct.name, strct.id})
    conn
    |> assign(:tags, tags)
  end

  defp load_categories_and_option_types(conn, _params) do
    get_option_types = Repo.all(from strct in OptionType, select: {strct.name, strct.id})
    categories = Excommerce.Query.Category.leaf_categories_name_and_id(Repo)
    conn
    |> assign(:get_option_types, get_option_types)
    |> assign(:categories, categories)
  end
end
