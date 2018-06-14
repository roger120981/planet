defmodule Excommerce.SearchProduct do
  use Ecto.Schema
  import Ecto.Changeset


  schema "abstract table:search_product" do
    field :name, :string, virtual: true
  end

  def changeset(product, attrs \\ %{}) do
    product
      |> cast(attrs, [:name])
  end

end
