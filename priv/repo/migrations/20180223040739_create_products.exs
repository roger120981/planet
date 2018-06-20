defmodule Excommerce.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :text
      add :permalink, :string
      add :available_on, :date
      add :deleted_at, :date
      add :meta_description, :text
      add :meta_keywords, :text

      timestamps()
    end

	create unique_index(:products, [:permalink])
  end
end
