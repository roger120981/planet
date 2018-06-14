defmodule Excommerce.Repo.Migrations.AddTagListToProduct do
  use Ecto.Migration

  def change do
	alter table(:products) do
      add :tag_list, :string
    end
  end
end
