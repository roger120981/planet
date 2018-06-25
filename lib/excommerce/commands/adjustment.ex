defmodule Excommerce.Command.Adjustment do
  use Excommerce.Command, schema: Excommerce.Adjustments.Adjustment

  def create_tax_adjustment!(repo, order, tax, calculated_amount) do
    order
    |> Ecto.build_assoc(:adjustments)
    |> Excommerce.Adjustments.Adjustment.changeset(%{amount: calculated_amount, tax_id: tax.id})
    |> repo.insert!
  end
end
