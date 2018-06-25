defmodule Excommerce.Command.Variant do
  use Excommerce.Command, schema: Excommerce.Catalog.Variant

  def insert_for_product(repo, product, params) do
    product
    |> Ecto.build_assoc(:variants)
    |> Excommerce.Catalog.Variant.create_variant_changeset(params)
    |> repo.insert
  end

  def update_for_product(repo, variant, product, params) do
    Excommerce.Catalog.Variant.update_variant_changeset(variant, product, params)
    |> repo.update
  end

end
