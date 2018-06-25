defmodule Excommerce.Query.LineItem do
  use Excommerce.Query, schema: Excommerce.Orders.LineItem

  def in_order_query(%Excommerce.Orders.Order{id: order_id}, query \\ Excommerce.Orders.LineItem) do
    from c in query, where: c.order_id == ^order_id
  end

  def in_order(repo, order, query \\ Excommerce.Orders.LineItem), do: repo.all(in_order_query(order, query))

  def with_variant_query(%Excommerce.Catalog.Variant{id: variant_id}, query \\ Excommerce.Orders.LineItem) do
    from c in query, where: c.variant_id == ^variant_id
  end

  def with_variant(repo, variant, query \\ Excommerce.Orders.LineItem), do: repo.all(with_variant_query(variant, query))

  def in_order_with_variant(order, variant),
    do: with_variant_query(variant, in_order_query(order))

  def in_order_with_variant(repo, order, variant),
    do: repo.one(in_order_with_variant(order, variant))
end
