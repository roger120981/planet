defmodule Excommerce.Accounts.UserRole do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users_roles" do

    timestamps()
  end

  @doc false
  def changeset(user_role, attrs) do
    user_role
    |> cast(attrs, [])
    |> validate_required([])
  end
end
