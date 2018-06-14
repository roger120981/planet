defmodule Excommerce.Catalog.Image do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias Excommerce.Catalog.Image

  schema "images" do
    field :filename, ExcommerceWeb.VariantImage.Type
    field :name, :string

    #belongs_to :variant, Excommerce.Catalog.Variant
    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:filename, :name])
    |> cast_attachments(attrs, [:filename])
    |> validate_required([:filename, :name])
  end
end
