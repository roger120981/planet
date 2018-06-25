defmodule Excommerce.Repo.Migrations.AddFeaturedToProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :featured, :boolean, default: false, null: false
    end
  end
end
