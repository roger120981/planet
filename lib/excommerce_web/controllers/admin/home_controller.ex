defmodule ExcommerceWeb.Admin.HomeController do
  use ExcommerceWeb, :admin_controller

  import ExcommerceWeb.Authorize

  plug :user_check

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
