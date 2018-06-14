defmodule Excommerce.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :filename, :string
      add :name, :string
      add :variant_id, references(:variants, on_delete: :delete_all) 
      timestamps()
    end
    create index(:images, [:variant_id])
  end
end
