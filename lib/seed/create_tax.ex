defmodule Seed.CreateTax do
  def seed! do
    taxes = ["VAT", "GST"]
    Enum.each(taxes, fn(tax_name) ->
      Excommerce.Taxation.Tax.changeset(%Excommerce.Taxation.Tax{}, %{name: tax_name})
      |> Excommerce.Repo.insert!
    end)
  end

end
