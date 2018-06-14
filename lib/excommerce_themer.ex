defmodule Excommerce.Themer do

  import Liquid.FileSystem, only: [read_template_file: 2]
  import Phoenix.Controller, only: [action_name: 1]

  def render(conn, template, assigns \\ []) do
    assigns = Enum.concat(assigns, conn.assigns)

    with {:ok, tpl} = read_template_file(template, template_context(assigns)),
         {:ok, final} = read_template_file("theme", layout_context(conn, assigns, tpl)),
         do: final
  end

  defp template_context(assigns), do: assigns_to_context(assigns)

  defp layout_context(conn, assigns, content_for_layout) do
    assigns_to_context([
      content_for_header: content_for_header(conn, assigns),
      content_for_layout: content_for_layout,
      settings: assigns[:settings], layout: true
    ])
  end

  defp content_for_header(conn, assigns) do
    """
    <title>#{page_title(conn, assigns)}</title>
    <meta name="description" content="#{assigns[:settings].website_description}" />
    """
  end

  defp page_title(conn, assigns) do
    sep = " &mdash; "
    settings = assigns[:settings]

    try do
      controller = conn.private[:phoenix_controller]
      action = action_name(conn)

      title = apply(controller, action, [conn, assigns, :page_title])
      title <> sep <> settings.website_title
    rescue
      e ->
        settings.website_description <> sep <> settings.website_title
    end

  end

  defp assigns_to_context(assigns),
    do: Enum.reduce(assigns, %{}, fn {k, v}, acc -> Map.put(acc, Atom.to_string(k), v) end)

end
