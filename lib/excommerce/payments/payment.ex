defmodule Excommerce.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Excommerce.Payments.{Payment, PaymentMethod}
  alias Excommerce.Orders.Order

  schema "payments" do
    belongs_to :order, Order
    belongs_to :payment_method, PaymentMethod
    field :amount, :decimal
    field :payment_state, :string, default: "authorized"
    field :transaction_id

    timestamps()
    
  end

  #@payment_states  ~w(authorized captured refunded)

  @required_fields ~w(payment_method_id amount payment_state)a
  @optional_fields ~w(transaction_id)a

  def authorized?(%Payment{payment_state: "authorized"}), do: true
  def authorized?(%Payment{}), do: false

  def captured?(%Payment{payment_state: "captured"}), do: true
  def captured?(%Payment{}), do: false

  def refunded?(%Payment{payment_state: "refunded"}), do: true
  def refunded?(%Payment{}), do: false

  def changeset(payment, attrs \\ %{}) do
    payment
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  # TODO: can we add errors while payment authorisation here ??
  def applicable_payment_changeset(payment, attrs) do
    payment
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end


  def capture_changeset(payment) do
    payment
    |> cast(%{"payment_state" => "captured"}, [:payment_state])
    |> validate_required([:payment_state])
  end

  def refund_changeset(payment) do
    payment
    |> cast(%{"payment_state" => "refunded"}, [:payment_state])
    |> validate_required([:payment_state])
  end

  def transaction_id_changeset(payment, attrs \\ %{}) do
    payment
    |> cast(attrs, [:transaction_id])
    |> validate_required([:transaction_id])
  end

end
