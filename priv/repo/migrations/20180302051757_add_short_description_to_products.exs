defmodule Excommerce.Repo.Migrations.AddShortDescriptionToProducts do
  use Ecto.Migration

  def change do
	alter table(:products) do
      add :short_description, :string
    end
  end
end
