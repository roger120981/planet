defmodule Excommerce.Repo.Migrations.AddMetaTitleToProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :meta_title, :text
    end
  end
end
