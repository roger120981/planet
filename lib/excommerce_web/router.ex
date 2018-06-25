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

    resources "/products", ProductController, only: [:show, :index]

    resources "/categories", CategoryController do
      get "/products", CategoryController, :associated_products, as: :products
    end

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

    resources "/countries", CountryController do
      resources "/states", StateController, only: [:create, :delete]
    end
    resources "/zones", ZoneController do
      resources "/members", ZoneMemberController, only: [:create, :delete]
    end

    resources "/cart", CartController, only: [:new, :edit, :create]

    resources "/categories", CategoryController
    resources "/themes", ThemeController, except: [:edit, :update, :new, :create]
    resources "/option_types", OptionTypeController, except: [:show]

    resources "/orders", OrderController, only: [:index, :show, :update, :edit] do
      resources "/line_items", LineItemController, only: [:create, :delete] do
        put "/update_fullfillment", LineItemController, :update_fullfillment
      end
      get "/checkout", CheckoutController, :checkout
      put "/checkout/next", CheckoutController, :next
      put "/checkout/back", CheckoutController, :back
      resources "/payments", PaymentController, only: [:show] do
        put "/refund",  PaymentController, :refund,  as: :refund
        put "/capture", PaymentController, :capture, as: :capture
      end
    end

    resources "/users", UserController do
      get "/all_pending_orders", UserController, :all_pending_orders
    end

    resources "/users", UserController

    get "/settings", SettingsController, :show
    put "/settings", SettingsController, :update
    put "/settings/theme", SettingsController, :update_theme
    get "/settings/payment", SettingsController,  :payment_method_settings
    get "/settings/shipping", SettingsController, :shipping_method_settings
    post "/settings/payment", SettingsController,  :update_payment_method_settings
    post "/settings/shipping", SettingsController, :update_shipping_method_settings
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExcommerceWeb do
  #   pipe_through :api
  # end
end
