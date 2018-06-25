defmodule ExcommerceWeb.TaxCalculator do

  def calculate_taxes(repo, order) do
    taxes = Excommerce.Query.Tax.all(repo)
    _tax_adjustments = Enum.map(taxes, fn (tax) ->
      Excommerce.Command.Adjustment.create_tax_adjustment!(repo, order, tax, 20.00)
    end)
  end

end
