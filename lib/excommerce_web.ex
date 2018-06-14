defmodule ExcommerceWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use ExcommerceWeb, :controller
      use ExcommerceWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: ExcommerceWeb
      import Plug.Conn
      import ExcommerceWeb.Router.Helpers
      import ExcommerceWeb.Gettext
      alias Excommerce.Repo
    end
  end

  def admin_controller do
    quote do
      use Phoenix.Controller, namespace: ExcommerceWeb.Admin
      import Plug.Conn
      import ExcommerceWeb.Router.Helpers
      import ExcommerceWeb.Gettext
      import Ecto
      import Ecto.Query
      alias Excommerce.Repo
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/excommerce_web/templates",
                        namespace: ExcommerceWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import ExcommerceWeb.Router.Helpers
      import ExcommerceWeb.ErrorHelpers
      import ExcommerceWeb.Gettext

      import NavigationHelper
      import BreadcrumbsHelper
      import ExcommerceWeb.FormHelpers

      def render_shared(template, assigns \\ []) do
        render(ExcommerceWeb.Admin.SharedView, template, assigns)
      end
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import ExcommerceWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
