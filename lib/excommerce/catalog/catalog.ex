defmodule Excommerce.Catalog do
  @moduledoc """
  The boundary for the Catalog system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Excommerce.Catalog.{Product, OptionType, Tag, Variant, Category}
  alias Excommerce.Repo

  # Context functions for products
  def list_products do
    Repo.all(Product)
  end

  def insert_product(attrs \\ %{}) do
    %Product{available_on: Date.utc_today()}
    |> Product.create_changeset(attrs)
    |> Repo.insert
  end

  def list_option_types do
    Repo.all(OptionType)
  end

  def insert_option_type(attrs \\ %{}) do
    %OptionType{}
    |> OptionType.changeset(attrs)
    |> Repo.insert
  end

  def variant_for_product(product) do
    from v in Variant, where: v.product_id == ^product.id
  end

  def insert_variant_for_product(product, params) do
    product
    |> Ecto.build_assoc(:variants)
    |> Excommerce.Catalog.Variant.create_variant_changeset(product, params)
    |> Repo.insert
  end

  def update_variant_for_product(variant, product, variant_params) do
    Excommerce.Catalog.Variant.update_variant_changeset(variant, product, variant_params)
    |> Repo.update
  end

  def list_categories do
    Repo.all(Category)
  end

  def cat_name_ids do
    Repo.all(from c in Category, select: {c.name, c.id})
  end

  def insert_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert
  end

  def get_category_id(id) do
    Category
    |> Repo.get(id)
  end

  def names_and_id_excluding_id(id) do
    Repo.all(from c in Category, select: {c.name, c.id}, where: c.id != ^id)
  end

  def update_category(category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update
  end

end
