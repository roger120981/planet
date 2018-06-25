defmodule Excommerce.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Excommerce.Slug
  alias Excommerce.Catalog.{Variant, Tag, ProductTag, ProductOptionType, ProductCategory}
  alias Excommerce.Repo
  alias Excommerce.Validations.Date

  @derive {Phoenix.Param, key: :permalink}
  schema "products" do
    field :available_on, :date
    field :deleted_at, :date
    field :description, :string
    field :meta_description, :string
    field :meta_keywords, :string
    field :name, :string
    field :permalink, :string
    field :short_description, :string
    field :meta_title, :string
    field :featured, :boolean

    field :tag_list, :string

    has_one :master, Variant, on_delete: :delete_all, on_replace: :delete
    has_many :variants, Variant, on_delete: :delete_all, on_replace: :delete

    has_many :product_option_types, ProductOptionType, on_delete: :delete_all, on_replace: :delete
    has_many :option_types, through: [:product_option_types, :option_type]

    has_many :product_categories, ProductCategory, on_delete: :delete_all, on_replace: :delete
    has_many :categories, through: [:product_categories, :category]

    many_to_many :tags, Tag, join_through: ProductTag, on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :permalink, :available_on, :featured, :meta_title, :deleted_at, :tag_list, :short_description, :meta_description, :meta_keywords])
  end

  @doc " Main product changeset for store."
  def create_changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :permalink, :available_on, :tag_list, :featured, :meta_title, :deleted_at, :meta_description, :meta_keywords, :short_description])
    |> validate_required([:name, :description, :available_on, :meta_description, :meta_keywords])
    |> Slug.generate_slug()
    |> cast_assoc(:master, required: true, with: &Variant.create_master_changeset/2)
    |> cast_assoc(:product_option_types, with: &ProductOptionType.from_product_changeset/2)
    |> cast_assoc(:product_categories, with: &ProductCategory.from_product_changeset/2)
    |> put_assoc(:tags, parse_tags(attrs))
    |> unique_constraint(:permalink)
  end

  def update_changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :permalink, :available_on, :tag_list, :featured, :meta_title, :deleted_at, :meta_description, :meta_keywords, :short_description])
    |> validate_required([:name, :description, :available_on, :meta_description, :meta_keywords])
    |> Slug.generate_slug()
    |> cast_assoc(:master, required: true, with: &Variant.update_master_changeset/2)
    |> validate_available_on_lt_discontinue_on
    |> cast_assoc(:product_option_types, with: &ProductOptionType.from_product_changeset/2)
    |> cast_assoc(:product_categories, with: &ProductCategory.from_product_changeset/2)
    |> put_assoc(:tags, parse_tags(attrs))
    |> unique_constraint(:permalink)
  end

  defp validate_available_on_lt_discontinue_on(changeset) do
    changeset
    |> Date.validate_lt_date(:available_on, changed_discontinue_on(changeset))
  end

  defp changed_discontinue_on(changeset) do
    changed_master = get_change(changeset, :master)
    if changed_master do
      get_change(changed_master, :discontinue_on) || changed_master.data.discontinue_on
    else
      changeset.data.master.discontinue_on
    end
  end

  defp parse_tags(attrs)  do
    (attrs["tag_list"] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(& &1 == "")
    |> Enum.map(&get_or_insert_tag/1)
  end

  defp get_or_insert_tag(name) do
    Repo.get_by(Tag, name: name) || maybe_insert_tag(name)
  end

  defp maybe_insert_tag(name) do
    %Tag{}
    |> change(name: name)
    |> unique_constraint(:name)
    |> Repo.insert
    |> case do
         {:ok, tag} -> tag
         {:error, _} -> Repo.get_by!(Tag, name: name)
       end
  end
end
