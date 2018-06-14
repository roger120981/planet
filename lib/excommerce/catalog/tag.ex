defmodule Excommerce.Catalog.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Excommerce.Catalog.{Tag, Product, ProductTag}


  schema "tags" do
    field :name, :string
	  field :slug, :string
	
	  many_to_many :products, Product, join_through: ProductTag, on_delete: :delete_all, on_replace: :delete
	
    timestamps()
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name, :slug])
    |> validate_required([:name])
  end
end
