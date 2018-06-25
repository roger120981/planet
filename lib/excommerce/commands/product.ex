defmodule Excommerce.Command.Product do
  use Excommerce.Command, schema: Excommerce.Catalog.Product
  alias Excommerce.Catalog.Product

  def insert!(repo, params) do
    Product.create_changeset(%Product{}, params)
    |> repo.insert!
  end

  def update!(repo, existing, params) do
    Product.update_changeset(existing, params)
    |> repo.update!
  end

  def insert(repo, params) do
    Product.create_changeset(%Product{}, params)
    |> repo.insert
  end

  def update(repo, existing, params) do
    Product.update_changeset(existing, params)
    |> repo.update
  end

end
