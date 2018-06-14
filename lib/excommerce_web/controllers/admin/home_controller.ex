defmodule ExcommerceWeb.Admin.HomeController do
  use ExcommerceWeb, :admin_controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
