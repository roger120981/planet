defmodule Excommerce.Slug do
  import Ecto.Changeset, only: [get_change: 2, put_change: 3]

  def generate_slug(changeset, slug_base_field \\ :name) do
    # Note: Slug base field should be mandatory field
    # Check in cast or validate_required
    slug = get_change(changeset, :permalink) || get_name_change_when_slug_not_present(changeset, slug_base_field)
    if slug do
      put_change(changeset, :permalink, slugify(slug))
    else
      changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/, "-")
  end

  defp get_name_change_when_slug_not_present(changeset, slug_base_field) do
    changeset.data.permalink || get_change(changeset, slug_base_field)
  end
end
