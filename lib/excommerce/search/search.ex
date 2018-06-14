defmodule Excommerce.Search do
  import Ecto.{Query, Changeset}, warn: false

  alias Excommerce.{Catalog.Product, Repo}

  def filter_product(params) do
    filter_product(Product, params)
  end

  defp filter_product(queryable, params) do
    queryable
    |> filter_name(params)
  end

  defp filter_name(queryable, %{"name" => name}) when (is_nil(name) or name == "") do
    queryable
  end

  defp filter_name(queryable, %{"name" => name}) do
    from p in queryable,
         where: ilike(p.name, ^("%#{name}%"))
  end

  defp filter_name(queryable, _params) do
    queryable
  end
end
