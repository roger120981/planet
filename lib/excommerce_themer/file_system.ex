defmodule Excommerce.Themer.FileSystem do
  @moduledoc """
  This module is responsible for loading, parsing and rendering Liquid
  templates for a given theme. The theme is retrieved from the settings,
  assigned to `conn`.
  """

  alias Liquid.Template

  @doc """
  Reads the given template file.

  If given `context` is a %Liquid.Context{} structure, means the template
  to read is a snippet and extra logic is required.

  Excepting the above case, the `path` should already include the theme
  directory as well as the directory where liquid files exist
  which is either "templates" or "layouts".

  Returns `{:ok, rendered_template}` if succeed or `{:error, reason}` if
  it fails.
  """
  def read_template_file(root, path, %Liquid.Context{} = context) do
    read_snippet(root, path, context)
  end
  def read_template_file(root, path, %{"layout" => true} = context) do
    read_layout(root, path, context)
  end
  def read_template_file(root, path, context) do
    read_template(root, path, context)
  end

  defp read_layout(root, path, context) do
    root
    |> join_path("layouts", path, context)
    |> read_and_render(context)
  end

  defp read_snippet(root, path, context) do
    root
    |> join_path("snippets", path, context)
    |> read_and_render(context)
  end

  defp read_template(root, path, context) do
    root
    |> join_path("templates", path, context)
    |> read_and_render(context)
  end

  defp read_and_render(filepath, context) do
    with {:ok, bin} <- File.read(filepath) do
      template = Template.parse(bin)

      with {:ok, rendered, _} <- Template.render(template, context) do
        {:ok, rendered}
      end
    end
  end

  defp join_path(root, kind, path, context) do
    %{alias: theme_alias} = get_theme_from_context(context)

    root = Application.app_dir(:excommerce, root)

    Path.join([root, theme_alias, kind, path <> ".liquid"])
  end

  defp get_theme_from_context(%{assigns: assigns}), do: get_theme_from_context(assigns)
  defp get_theme_from_context(%{"settings" => %{theme: theme}}), do: theme
end
