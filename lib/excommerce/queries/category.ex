defmodule Excommerce.Query.Category do

  use Excommerce.Query, schema: Excommerce.Catalog.Category

  def parent_ids do
    from cat in Excommerce.Catalog.Category,
      where: not is_nil(cat.parent_id),
      select: cat.parent_id
  end

  def get_root_cat do
    from cat in Excommerce.Catalog.Category,
      where: is_nil(cat.parent_id)
  end

  def get_root_cat(repo) do
    repo.all(get_root_cat())
  end

  def get_children_cat(repo)  do
    repo.all(parent_ids())
    |> children_cat
    |> repo.all
  end

  def children_cat(parent_ids) do
    from cat in Excommerce.Catalog.Category, where: cat.id in ^parent_ids
  end

  def with_associated_products do
    from cat in Excommerce.Catalog.Category,
     join: p_cat in assoc(cat, :product_categories),
     select: cat,
     distinct: cat.id
  end

  def leaf_categories(parent_ids) when is_list(parent_ids) do
    from cat in Excommerce.Catalog.Category, where: not cat.id in ^parent_ids
  end

  def leaf_categories(repo) do
    repo.all(parent_ids())
    |> leaf_categories
    |> repo.all
  end

  def leaf_categories_name_and_id(repo) do
    ids = repo.all(parent_ids())
    repo.all from p in leaf_categories(ids), select: {p.name, p.id}
  end

  def with_associated_products(repo) do
    repo.all(with_associated_products())
  end

  def names_and_id do
    from c in Excommerce.Catalog.Category, select: {c.name, c.id}
  end

  def names_and_id(repo) do
    repo.all(names_and_id())
  end

  def names_and_id_excluding_id(id) do
    from c in names_and_id(), where: c.id != ^id
  end

  def names_and_id_excluding_id(repo, id) do
    repo.all(names_and_id_excluding_id(id))
  end

end