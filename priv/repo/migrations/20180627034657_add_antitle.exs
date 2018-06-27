defmodule Excommerce.Repo.Migrations.AddAntitle do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :ante_title, :string
    end
  end
end
