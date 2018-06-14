defmodule Excommerce.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :score, :float
      add :title, :string
      add :content, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:reviews, [:user_id])
    create index(:reviews, [:product_id])
  end
end
