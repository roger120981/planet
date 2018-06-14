defmodule Excommerce.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :string
      add :permalink, :string
      add :available_on, :date
      add :deleted_at, :date
      add :meta_description, :string
      add :meta_keywords, :string

      timestamps()
    end

	create unique_index(:products, [:permalink])
  end
end
