defmodule ExcommerceWeb.Admin.PaymentView do
  use ExcommerceWeb, :view

  alias Excommerce.Payments.Payment

  defdelegate authorized?(payment), to: Payment
  defdelegate captured?(payment), to: Payment
  defdelegate refunded?(payment), to: Payment

end
