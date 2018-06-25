defmodule ExcommerceWeb.Workflow.MoveBackToTaxState do
  alias Ecto.Multi

  def run(repo, order), do: repo.transaction(steps(order))

  def steps(order) do
    Multi.new()
    |> Multi.delete_all(:delete_payments, Excommerce.Query.Payment.for_order(order))
    |> Multi.update(:update_state, Excommerce.Orders.Order.state_changeset(order, %{state: "tax"}))
  end

  # defp delete_payments(_changes, repo, order),
  #   do: Shop.Command.Order.delete_payment(repo, order)
  # end
end
