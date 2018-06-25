defmodule Excommerce.Catalog.VariantOptionValue do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Catalog.{VariantOptionValue, Variant, OptionValue}


  schema "variant_option_values" do
	field :option_type_id, :integer

    belongs_to :variant, Variant
    belongs_to :option_value, OptionValue
	
    timestamps()
  end

  @doc false
  def changeset(variant_option_value, attrs) do
    variant_option_value
    |> cast(attrs, [:variant_id, :option_value_id])
    |> validate_required([:variant_id, :option_value_id])
  end
  
  @required_fields ~w(option_value_id option_type_id)a
  @optional_fields ~w()a
  def from_variant_changeset(variant_option_value, attrs \\ %{}) do
    variant_option_value
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> remove_if_not_in_valid_product_option_type
  end

  def remove_if_not_in_valid_product_option_type(changeset) do
    if changeset.data.id do
      variant = Excommerce.Repo.get_by(Variant, id: changeset.data.variant_id)
                              |> Excommerce.Repo.preload(product: :product_option_types)
      product_option_types = variant.product.product_option_types
      available_product_option_type_ids = Enum.map(product_option_types, &(&1.option_type_id))
      if Enum.any?(available_product_option_type_ids, &(&1 == changeset.data.option_type_id)) do
        changeset
      else
        %{changeset | action: :delete}
      end
    else
      changeset
    end
  end
end
