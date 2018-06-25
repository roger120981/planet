defmodule Seed.CreatePaymentMethod do
  def seed! do
    payment_methods = ["cheque", "stripe", "braintree"]
    Enum.each(payment_methods, fn(method_name) ->
      Excommerce.Payments.PaymentMethod.changeset(%Excommerce.Payments.PaymentMethod{}, %{name: method_name, enabled: true})
      |> Excommerce.Repo.insert!
    end)
  end
end
