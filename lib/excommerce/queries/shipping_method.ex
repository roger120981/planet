defmodule Excommerce.Query.ShippingMethod do
  use Excommerce.Query, schema: Excommerce.Shipments.ShippingMethod

  def enabled_shipping_methods do
    from shipp in Excommerce.Shipments.ShippingMethod,
    where: shipp.enabled
  end

  def enabled_shipping_methods(repo), do: repo.all(enabled_shipping_methods())

end
