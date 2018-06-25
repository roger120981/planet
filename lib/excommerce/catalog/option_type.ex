defmodule Excommerce.Catalog.OptionType do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Catalog.{OptionType, OptionValue}


  schema "option_types" do
	  field :name, :string
    field :presentation, :string
    field :position, :integer

    has_many :option_values, OptionValue

    timestamps()
  end

  @doc false
  def changeset(option_type, attrs \\ %{}) do
    option_type
    |> cast(attrs, [:name, :presentation])
    |> validate_required([:name, :presentation])
	  |> cast_assoc(:option_values)
    |> unique_constraint(:name)
  end
end
