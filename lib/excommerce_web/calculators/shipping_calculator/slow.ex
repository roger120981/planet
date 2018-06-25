defmodule ExcommerceWeb.ShippingCalculator.Slow do
  use ExcommerceWeb.ShippingCalculator.Base, shipping_rate: 2

  def applicable?(_shipping_unit) do
    false
  end
end
