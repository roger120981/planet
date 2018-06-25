defmodule ExcommerceWeb.Admin.UserController do
  use ExcommerceWeb, :admin_controller

  alias Excommerce.Accounts.User

  plug :scrub_params, "user" when action in [:create, :update]

  def index(conn, _params) do
    users = Excommerce.Query.User.all(Repo)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Excommerce.Command.User.insert(Repo, user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: admin_user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Excommerce.Query.User.get!(Repo, id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Excommerce.Query.User.get!(Repo, id)
    changeset = User.changeset(user, %{})
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Excommerce.Query.User.get!(Repo, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: admin_user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Excommerce.Query.User.get!(Repo, id)
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Excommerce.Command.User.delete!(Repo, user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: admin_user_path(conn, :index))
  end

  def all_pending_orders(conn, %{"user_id" => id}) do
    user   = Excommerce.Query.User.get!(Repo, id)
    orders = Excommerce.Query.User.all_abandoned_orders(Repo, user)
    render(conn, "pending_orders.json",  orders: orders)
  end
end
