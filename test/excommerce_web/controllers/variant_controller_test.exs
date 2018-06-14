defmodule ExcommerceWeb.VariantControllerTest do
  use ExcommerceWeb.ConnCase

  alias Excommerce.Catalog

  @create_attrs %{cost_currency: "some cost_currency", cost_price: "120.5", depth: "120.5", discontinue_on: ~D[2010-04-17], height: "120.5", image: "some image", is_master: true, sku: "some sku", weight: "120.5"}
  @update_attrs %{cost_currency: "some updated cost_currency", cost_price: "456.7", depth: "456.7", discontinue_on: ~D[2011-05-18], height: "456.7", image: "some updated image", is_master: false, sku: "some updated sku", weight: "456.7"}
  @invalid_attrs %{cost_currency: nil, cost_price: nil, depth: nil, discontinue_on: nil, height: nil, image: nil, is_master: nil, sku: nil, weight: nil}

  def fixture(:variant) do
    {:ok, variant} = Catalog.create_variant(@create_attrs)
    variant
  end

  describe "index" do
    test "lists all variants", %{conn: conn} do
      conn = get conn, variant_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Variants"
    end
  end

  describe "new variant" do
    test "renders form", %{conn: conn} do
      conn = get conn, variant_path(conn, :new)
      assert html_response(conn, 200) =~ "New Variant"
    end
  end

  describe "create variant" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, variant_path(conn, :create), variant: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == variant_path(conn, :show, id)

      conn = get conn, variant_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Variant"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, variant_path(conn, :create), variant: @invalid_attrs
      assert html_response(conn, 200) =~ "New Variant"
    end
  end

  describe "edit variant" do
    setup [:create_variant]

    test "renders form for editing chosen variant", %{conn: conn, variant: variant} do
      conn = get conn, variant_path(conn, :edit, variant)
      assert html_response(conn, 200) =~ "Edit Variant"
    end
  end

  describe "update variant" do
    setup [:create_variant]

    test "redirects when data is valid", %{conn: conn, variant: variant} do
      conn = put conn, variant_path(conn, :update, variant), variant: @update_attrs
      assert redirected_to(conn) == variant_path(conn, :show, variant)

      conn = get conn, variant_path(conn, :show, variant)
      assert html_response(conn, 200) =~ "some updated cost_currency"
    end

    test "renders errors when data is invalid", %{conn: conn, variant: variant} do
      conn = put conn, variant_path(conn, :update, variant), variant: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Variant"
    end
  end

  describe "delete variant" do
    setup [:create_variant]

    test "deletes chosen variant", %{conn: conn, variant: variant} do
      conn = delete conn, variant_path(conn, :delete, variant)
      assert redirected_to(conn) == variant_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, variant_path(conn, :show, variant)
      end
    end
  end

  defp create_variant(_) do
    variant = fixture(:variant)
    {:ok, variant: variant}
  end
end
