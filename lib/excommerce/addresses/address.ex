defmodule Excommerce.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Addresses.{Address, State, Country, UserAddress}
  alias Excommerce.Orders.{OrderBillingAddress, OrderShippingAddress}
  
  
  schema "addresses" do
    field :address_line_1, :string
    field :address_line_2, :string

    belongs_to :state, State
    belongs_to :country, Country

    has_one :user_address, UserAddress
    has_one :user, through: [:user_address, :user]

    has_many :order_billing_addresses, OrderBillingAddress
    has_many :billing_orders, through: [:order_billing_addresses, :order]

    has_many :order_shipping_addresses, OrderShippingAddress
    has_many :shipping_order, through: [:order_shipping_addresses, :order]

    timestamps()
    
  end

  @required_fields ~w(address_line_1 address_line_2 country_id state_id)a
  @optional_fields ~w()a

  # currently called by order's build assoc
  # ensure all other keys are set
  def changeset(address, attrs \\ %{}) do
    address
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:address_line_1, min: 10)
    |> validate_length(:address_line_2, min: 10)
    |> foreign_key_constraint(:state_id)
    |> foreign_key_constraint(:country_id)
  end

  def registered_user_changeset(address, attrs \\ %{}) do
    changeset(address, attrs)
    |> cast_assoc(:user_address, required: true)
  end

end
