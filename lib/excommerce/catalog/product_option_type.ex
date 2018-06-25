defmodule Excommerce.Catalog.ProductOptionType do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Catalog.{Product, ProductOptionType, OptionType}


  schema "product_option_types" do
	  field :delete, :boolean, virtual: true

    belongs_to :product, Product
    belongs_to :option_type, OptionType

    timestamps()
  end

  @doc false
  def changeset(product_option_type, attrs) do
    product_option_type
    |> cast(attrs, [:product_id, :option_type_id])
    |> validate_required([:product_id, :option_type_id])
  end
  
  def from_product_changeset(product_option_type, attrs \\ %{}) do
    cast(product_option_type, attrs, ~w(option_type_id), ~w(delete))
    |> set_delete_action
    |> unique_constraint(:option_type_id, name: :unique_product_option_types_index)
  end

  def set_delete_action(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
