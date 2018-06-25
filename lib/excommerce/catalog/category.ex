defmodule Excommerce.Catalog.Category do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Catalog.{Category, ProductCategory}


  schema "categories" do
    field :name, :string
    field :icon, :string
    belongs_to :parent, Category
    has_many :children, Category, foreign_key: :parent_id

    has_many :product_categories, ProductCategory
    has_many :products, through: [:product_categories, :product]

    timestamps()
  end

  @doc false
  def changeset(category, attrs \\ %{}) do
    category
    |> cast(attrs, [:name, :parent_id, :icon])
    |> validate_required([:name])
    |> foreign_key_constraint(:parent_id)
  end
  
  def children_changeset(category, attrs \\ %{}) do
    changeset(category, attrs)
    |> cast_assoc(:children)
  end
end
