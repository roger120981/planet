defmodule Excommerce.CatalogTest do
  use Excommerce.DataCase

  alias Excommerce.Catalog

  describe "variants" do
    alias Excommerce.Catalog.Variant

    @valid_attrs %{cost_currency: "some cost_currency", cost_price: "120.5", depth: "120.5", discontinue_on: ~D[2010-04-17], height: "120.5", image: "some image", is_master: true, sku: "some sku", weight: "120.5"}
    @update_attrs %{cost_currency: "some updated cost_currency", cost_price: "456.7", depth: "456.7", discontinue_on: ~D[2011-05-18], height: "456.7", image: "some updated image", is_master: false, sku: "some updated sku", weight: "456.7"}
    @invalid_attrs %{cost_currency: nil, cost_price: nil, depth: nil, discontinue_on: nil, height: nil, image: nil, is_master: nil, sku: nil, weight: nil}

    def variant_fixture(attrs \\ %{}) do
      {:ok, variant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalog.create_variant()

      variant
    end

    test "list_variants/0 returns all variants" do
      variant = variant_fixture()
      assert Catalog.list_variants() == [variant]
    end

    test "get_variant!/1 returns the variant with given id" do
      variant = variant_fixture()
      assert Catalog.get_variant!(variant.id) == variant
    end

    test "create_variant/1 with valid data creates a variant" do
      assert {:ok, %Variant{} = variant} = Catalog.create_variant(@valid_attrs)
      assert variant.cost_currency == "some cost_currency"
      assert variant.cost_price == Decimal.new("120.5")
      assert variant.depth == Decimal.new("120.5")
      assert variant.discontinue_on == ~D[2010-04-17]
      assert variant.height == Decimal.new("120.5")
      assert variant.image == "some image"
      assert variant.is_master == true
      assert variant.sku == "some sku"
      assert variant.weight == Decimal.new("120.5")
    end

    test "create_variant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_variant(@invalid_attrs)
    end

    test "update_variant/2 with valid data updates the variant" do
      variant = variant_fixture()
      assert {:ok, variant} = Catalog.update_variant(variant, @update_attrs)
      assert %Variant{} = variant
      assert variant.cost_currency == "some updated cost_currency"
      assert variant.cost_price == Decimal.new("456.7")
      assert variant.depth == Decimal.new("456.7")
      assert variant.discontinue_on == ~D[2011-05-18]
      assert variant.height == Decimal.new("456.7")
      assert variant.image == "some updated image"
      assert variant.is_master == false
      assert variant.sku == "some updated sku"
      assert variant.weight == Decimal.new("456.7")
    end

    test "update_variant/2 with invalid data returns error changeset" do
      variant = variant_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_variant(variant, @invalid_attrs)
      assert variant == Catalog.get_variant!(variant.id)
    end

    test "delete_variant/1 deletes the variant" do
      variant = variant_fixture()
      assert {:ok, %Variant{}} = Catalog.delete_variant(variant)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_variant!(variant.id) end
    end

    test "change_variant/1 returns a variant changeset" do
      variant = variant_fixture()
      assert %Ecto.Changeset{} = Catalog.change_variant(variant)
    end
  end
end
