defmodule TemplateHelper do
  @moduledoc """
  Template Helper for Store.
  """
  alias Excommerce.Themer

  defp do_render(conn, status, template, assigns \\ []) do
    body = Themer.render(conn, template, assigns)

    conn
    |> put_resp_header("Content-Type", "text/html")
    |> send_resp(status, body)
  end
end
