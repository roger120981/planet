defmodule Excommerce.Query.Variant do
  use Excommerce.Query, schema: Excommerce.Catalog.Variant

  def master_variants do
    from m in Excommerce.Catalog.Variant, where: m.is_master
  end

  def not_master_variants do
    from m in Excommerce.Catalog.Variant, where: not(m.is_master), preload: [option_values: :option_type]
  end

  def for_product(product) do
    from v in Excommerce.Catalog.Variant, where: v.product_id == ^product.id
  end

  def for_product(repo, product) do
    repo.all(for_product(product))
  end


end
