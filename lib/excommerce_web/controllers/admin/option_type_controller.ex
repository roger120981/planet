defmodule ExcommerceWeb.Admin.OptionTypeController do
  use ExcommerceWeb, :admin_controller

  alias Excommerce.Catalog.OptionType


  def index(conn, _params) do
    option_types = Excommerce.Catalog.list_option_types()
    render(conn, "index.html", option_types: option_types)
  end

  def new(conn, _params) do
    changeset = OptionType.changeset(%OptionType{}, _params)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"option_type" => option_type_params}) do
    case Excommerce.Catalog.insert_option_type(option_type_params) do
      {:ok, _option_type} ->
        conn
        |> put_flash(:info, "Option type created successfully.")
        |> redirect(to: admin_option_type_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
     option_type = Repo.get(OptionType, id) |> Repo.preload(:option_values)
     changeset = OptionType.changeset(option_type, %{})
     render(conn, "edit.html", option_type: option_type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "option_type" => option_type_params}) do
    option_type = Repo.get(OptionType, id)|> Repo.preload(:option_values)
    changeset = OptionType.changeset(option_type, option_type_params)

    case Repo.update(changeset) do
      {:ok, option_type} ->
        conn
        |> put_flash(:info, "Option type updated successfully.")
        |> redirect(to: admin_option_type_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", option_type: option_type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    option_type = Repo.get(OptionType, id)
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(option_type)

    conn
    |> put_flash(:info, "Option type deleted successfully.")
    |> redirect(to: admin_option_type_path(conn, :index))
  end
end
