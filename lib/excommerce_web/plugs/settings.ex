defmodule ExcommerceWeb.Plug.Settings do
  import Plug.Conn

  alias Excommerce.Settings

  def init(opts), do: opts

  def call(conn, _opts) do
    assign(conn, :settings, Settings.get_settings())
  end
end
