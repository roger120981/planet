defmodule ExcommerceWeb.Router do
  use ExcommerceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phauxth.Authenticate
    plug Phauxth.Remember
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExcommerceWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/confirm", ConfirmController, :index
    resources "/password_resets", PasswordResetController, only: [:new, :create]
    get "/password_resets/edit", PasswordResetController, :edit
    put "/password_resets/update", PasswordResetController, :update
  end

  scope "/admin", ExcommerceWeb.Admin, as: :admin do
    pipe_through :browser

    get "/", HomeController, :index

    resources "/products", ProductController do
      resources "/variants", VariantController
    end

    resources "/categories", CategoryController
    resources "/themes", ThemeController, except: [:edit, :update, :new, :create]
    resources "/option_types", OptionTypeController, except: [:show]

    get "/settings", SettingsController, :show
    put "/settings", SettingsController, :update
    put "/settings/theme", SettingsController, :update_theme
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExcommerceWeb do
  #   pipe_through :api
  # end
end
