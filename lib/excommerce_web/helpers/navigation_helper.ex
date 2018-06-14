defmodule NavigationHelper do
  @moduledoc """
  Twitter Bootstrap 3 navigation helpers for Store.
  """

  use Phoenix.HTML


  def general_link_to(text, opts) when is_binary(text) and is_list(opts) do
    final_opts =
      opts
      |> render_icon

    content_tag :span, final_opts[:class]
    link(text, final_opts)
  end
  def link_to_products(text, opts) do
    final_opts =
      opts
      |> render_icon

    content_tag :span, final_opts[:class]
    link(text, final_opts)
  end

  defp render_icon(opts) do
    if Keyword.has_key?(opts, :icon) do
      Keyword.put(opts, :class, "#{opts[:class]} icon icon-#{opts[:icon]}")

    else
      opts
    end
  end

  defp prepare_options(opts) do
    []
    |> put_when_in_list(:icon, opts)
  end

  defp put_when_in_list(final_opts, symbol, opts) do
    cond do
      Keyword.has_key? opts, symbol ->
        Keyword.put final_opts, symbol, opts[symbol]
      true ->
        final_opts
    end
  end
end
