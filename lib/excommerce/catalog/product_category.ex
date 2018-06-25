defmodule Excommerce.Catalog.ProductCategory do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Catalog.{ProductCategory, Product, Category}


  schema "product_categories" do
    belongs_to :product, Product
    belongs_to :category, Category

    field :delete, :boolean, virtual: true, default: false

    timestamps()
  end

  @doc false
  def changeset(product_category, attrs) do
    product_category
    |> cast(attrs, [:product_id, :category_id])
    |> validate_required([:product_id, :category_id])
  end
  
  def from_product_changeset(product_category, attrs \\ %{}) do
    cast(product_category, attrs, ~w(category_id), ~w(delete))
    |> set_delete_action
    |> unique_constraint(:category_id, name: :unique_product_category)
  end

  def set_delete_action(changeset) do
    if get_change(changeset, :delete) do
      %{changeset| action: :delete}
    else
      changeset
    end
  end
end
