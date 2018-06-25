defmodule Excommerce.Addresses.UserAddress do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Addresses.{Address, UserAddress}
  alias Excommerce.Accounts.User

  schema "user_addresses" do
    belongs_to :user, User
    belongs_to :address, Address

    timestamps()
    
  end

  @required_fields ~w()a
  @optional_fields ~w(user_id)a
  def changeset(user_address, attrs \\ %{}) do
    user_address
    |> cast(attrs, ~w(), @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:address, required: true)
  end

end
