defmodule ExcommerceWeb.Admin.ThemeController do
  use ExcommerceWeb, :admin_controller

  alias Excommerce.Themes

  def index(conn, params) do
    data = Themes.list_themes(params)

    render(conn, "index.html", themes: data.entries, page_number: data.page_number,
                               page_size: data.page_size, total_pages: data.total_pages,
                               total_entries: data.total_entries)
  end

  def show(conn, %{"id" => id}) do
    if theme = Themes.get_theme(id) do
      render(conn, "show.html", theme: theme)
    end
  end

  def delete(conn, %{"id" => id}) do
    if theme = Themes.get_theme(id) do
      with {:ok, _theme} = Themes.delete_theme(theme) do
        conn
        |> put_flash(:info, :deleted)
        |> redirect(to: admin_theme_path(conn, :index))
      end
    end
  end
end
