defmodule Seed.CreateShippingMethod do
  def seed! do
    shipping_methods = ["regular", "express"]
    Enum.each(shipping_methods, fn(method_name) ->
      Excommerce.Shipments.ShippingMethod.changeset(%Excommerce.Shipments.ShippingMethod{}, %{name: method_name, enabled: true})
      |> Excommerce.Repo.insert!
    end)
  end
end
