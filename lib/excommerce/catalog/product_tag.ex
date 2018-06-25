defmodule Excommerce.Catalog.ProductTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Excommerce.Catalog.{ProductTag, Product, Tag}

  @primary_key false
  schema "product_tags" do
    belongs_to :product, Product
    belongs_to :tag, Tag

    timestamps()
  end

  @doc false
  def changeset(product_tag, attrs) do
    product_tag
    |> cast(attrs, [:product_id, :tag_id])
    |> validate_required([:product_id, :tag_id])
  end
end
