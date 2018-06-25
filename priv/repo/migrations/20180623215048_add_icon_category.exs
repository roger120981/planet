defmodule Excommerce.Repo.Migrations.AddIconCategory do
  use Ecto.Migration

  def change do
    alter table(:categories) do
      add :icon, :string
    end
  end
end
