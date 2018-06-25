defmodule ExcommerceWeb.Admin.SettingsController do
  use ExcommerceWeb, :admin_controller

  import ExcommerceWeb.Authorize
  alias Excommerce.Settings
  alias Excommerce.Settings.Setting

  plug :user_check

  def show(conn, _params) do
    if settings = Settings.get_settings() do
      changeset = Settings.change_settings(settings)
      render(conn, "show.html", settings: settings, changeset: changeset)
    end
  end

  def update(conn, %{"setting" => settings_params}) do
    if settings = Settings.get_settings() do
      with {:ok, %Setting{} = _settings} <- Settings.update_settings(settings, settings_params) do
        conn
        |> put_flash(:info, :updated)
        |> redirect(to: admin_settings_path(conn, :show))
      else
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "show.html", settings: settings, changeset: changeset)
      end
    end
  end

  def update_theme(conn, %{"setting" => settings_params}) do
    if settings = Settings.get_settings() do
      with {:ok, %Setting{} = _settings} <- Settings.update_settings(settings, settings_params) do
        conn
        |> put_flash(:info, :applied)
        |> redirect(to: admin_theme_path(conn, :show, settings_params["theme_id"]))
      end
    end
  end

  def shipping_method_settings(conn, _params) do
    shipping_methods = Excommerce.Query.ShippingMethod.all(Repo)
    render(conn, "shipping.html", shipping_methods: shipping_methods)
  end

  def update_shipping_method_settings(conn, %{"shipping_methods" => params}) do
    Excommerce.Command.ShippingMethod.make_active_enabled_and_disable_other(Repo, params)
    conn
    |> put_flash(:info, "Updated Shipping methods succesfully")
    |> redirect(to: admin_settings_path(conn, :shipping_method_settings))
  end

  def payment_method_settings(conn, _params) do
    payment_methods = Excommerce.Query.PaymentMethod.all(Repo)
    render(conn, "payment.html", payment_methods: payment_methods)
  end

  def update_payment_method_settings(conn, %{"payment_methods" => params}) do
    Excommerce.Command.PaymentMethod.make_active_enabled_and_disable_other(Repo, params)
    conn
    |> put_flash(:info, "Updated Payment methods succesfully")
    |> redirect(to: admin_settings_path(conn, :payment_method_settings))
  end
end
