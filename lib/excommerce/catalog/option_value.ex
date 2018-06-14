defmodule Excommerce.Catalog.OptionValue do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Catalog.{OptionValue, OptionType}


  schema "option_values" do
	  field :name, :string
    field :presentation, :string
    field :position, :integer
    field :delete, :boolean, virtual: true

    belongs_to :option_type, OptionType

    timestamps()
  end

  @doc false
  def changeset(%OptionValue{} = option_value, attrs \\ %{}) do
    option_value
    |> cast(attrs, [:delete, :name, :presentation])
    |> validate_required([:name, :presentation])
	  |> unique_constraint(:name, name: :option_values_name_option_type_index)
    |> set_delete_action
  end
  
  def set_delete_action(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
