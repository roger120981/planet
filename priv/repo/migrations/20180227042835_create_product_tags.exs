defmodule Excommerce.Repo.Migrations.CreateProductTags do
  use Ecto.Migration

  def change do
    create table(:product_tags) do
      add :product_id, references(:products, on_delete: :nothing)
      add :tag_id, references(:tags, on_delete: :nothing)

      timestamps()
    end
	create unique_index(:product_tags, [:tag_id, :product_id], name: :unique_product_tag)
	
  end
end
