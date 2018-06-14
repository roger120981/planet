defmodule Excommerce.Repo.Migrations.CreateThemes do
  use Ecto.Migration

  def change do
    create table(:themes) do
      add :alias, :string
      add :name, :string
      add :description, :string

      timestamps()
    end
    create unique_index(:themes, [:alias, :name])
  end
end
