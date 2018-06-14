defmodule BreadcrumbsHelper do
  @moduledoc """
  Twitter Bootstrap 3 breadcrumbs helpers for Store.
  """

  use Phoenix.HTML
  import ExcommerceWeb.Gettext
  import ExcommerceWeb.Router.Helpers

  def breadcrumbs(args) do
    content_tag :h1 do
      content_tag :nav do
        content_tag :ol, class: "breadcrumb" do
        apply(__MODULE__, :crumbs, args)
        |> render
        end
      end
    end
  end

  defp render([current | tail]) do
    ([render_crumb(current, :current)] ++ Enum.map(tail, &render_crumb&1))
    |> Enum.reverse
  end

  defp render_crumb({text, _path}, :current) do
    content_tag :li, do: text
  end

  defp render_crumb({text, path}) do
    content_tag :li, do: link text, to: path
  end

  def crumbs(conn, :root) do
    [{gettext("Home"), (admin_home_path(conn, :index))}]
  end

  def crumbs(conn, :product) do
    [{gettext("Products"), (admin_product_path(conn, :index))} | crumbs(conn, :root)]
  end

  def crumbs(conn, :new_product) do
    [{gettext("New product"), (admin_product_path(conn, :index))} | crumbs(conn, :product)]
  end

  def crumbs(conn, :edit_product) do
    [{gettext("Edit product"), (admin_product_path(conn, :index))} | crumbs(conn, :product)]
  end
end
