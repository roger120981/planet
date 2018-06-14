defmodule ExcommerceWeb.Admin.LayoutView do
  use ExcommerceWeb, :view
  use Scrivener.HTML
  
  def js_view_name(view_module, view_template) do
    "Admin." <> view_module_name(view_module) <> "." <> view_template_name(view_template)
  end

  defp view_module_name(module_name) do
    module_name
    |> Phoenix.Naming.resource_name
    |> Phoenix.Naming.camelize
  end

  defp view_template_name(template_name) do
    String.replace_suffix(template_name, ".html", "")
  end

  def with_sidebar(conn) do
    %{request_path: path} = conn
    case path do
      "/admin/products" -> "col-xs-12"
      "/admin/products/new" -> "col-xs-12"
      _ -> "col-xs-12"
     end
  end
end
