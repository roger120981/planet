defmodule Excommerce.Catalog.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias Excommerce.Catalog.Review


  schema "reviews" do
    field :content, :string
    field :score, :float
    field :title, :string
    field :user_id, :id
    field :product_id, :id

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:score, :title, :content])
    |> validate_required([:title, :content])
  end
end
