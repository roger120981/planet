defmodule Excommerce.Payments.PaymentMethod do

  use Ecto.Schema
  import Ecto.Changeset

  alias Excommerce.Payments.{Payment, PaymentMethod}

  schema "payment_methods" do
    field :name, :string
    has_many :payments, Payment
    field :enabled, :boolean, default: false
    
  end

  @required_fields ~w(name)a
  @optional_fields ~w(enabled)a

  def changeset(payment_method, attrs \\ %{}) do
    payment_method
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
