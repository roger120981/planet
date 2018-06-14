defmodule Excommerce.Themes.Theme do
  use Ecto.Schema
  import Ecto.Changeset


  schema "themes" do
    field :alias, :string
    field :description, :string
    field :name, :string

    has_one :setting, Excommerce.Settings.Setting
    timestamps()
  end

  @doc false
  def changeset(theme, attrs) do
    theme
    |> cast(attrs, [:alias, :name, :description])
    |> validate_required([:alias, :name, :description])
    |> unique_constraint(:alias)
  end
end
