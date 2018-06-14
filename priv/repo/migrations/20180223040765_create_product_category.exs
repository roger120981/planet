defmodule Excommerce.Repo.Migrations.CreateProductCategory do
  use Ecto.Migration

  def change do
    create table(:product_categories) do
      add :product_id, references(:products, on_delete: :nothing)
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end
	create unique_index(:product_categories, [:category_id, :product_id], name: :unique_product_category)
	
  end
end
