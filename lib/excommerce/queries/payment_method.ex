defmodule Excommerce.Query.PaymentMethod do
  use Excommerce.Query, schema: Excommerce.Payments.PaymentMethod

  def enabled_payment_methods do
    from pay in Excommerce.Payments.PaymentMethod,
    where: pay.enabled
  end

  def enabled_payment_methods(repo), do: repo.all(enabled_payment_methods())
end
