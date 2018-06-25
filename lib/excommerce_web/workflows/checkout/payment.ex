defmodule ExcommerceWeb.Workflow.Checkout.Payment do
  alias Ecto.Multi
  # pay and confirm here, remove the confirmation step

  def run(repo, order, params),
    do: repo.transaction(steps(repo, order, params))

  def order_with_preloads(repo, order) do
    order
    |> repo.preload([:payment])
  end

  def changeset_for_step(order, params \\ %{}) do
    Excommerce.Orders.Order.payment_changeset(order, params)
  end

  def view_data(repo, order),
    do: %{applicable_payment_methods: ExcommerceWeb.Invoice.generate_applicable_payment_invoices(repo, order)}

  def steps(repo, order, params) do
    order = order_with_preloads(repo, order)
    changeset = changeset_for_step(order, params)
    Multi.new()
    |> Multi.append(pre_transition(repo, changeset))
    |> Multi.update(:order, changeset)
    |> Multi.run(:post, &(post_transition(repo, &1.order, &1.transaction_id)))
  end

  # before accepting payment confirm if everything in cart is available
  def pre_transition(repo, order_changeset) do
    Multi.new()
    |> Multi.append(ExcommerceWeb.Workflow.ConfirmAvailabilityInOrderChangeset.steps(repo, order_changeset))
    |> Multi.append(ExcommerceWeb.Workflow.AuthorizePayment.steps(repo, order_changeset))
  end

  def post_transition(repo, order, transaction_id) do
    Multi.new()
    |> Multi.update(:add_transaction_id, Excommerce.Payments.Payment.transaction_id_changeset(order.payment, %{transaction_id: transaction_id}))
    |> Multi.append(ExcommerceWeb.Workflow.AcquireStockFromVariantForOrder.steps(repo, order))
    |> Multi.update(:confirm_order, Excommerce.Orders.Order.confirmation_changeset(order, %{confirm: true, state: "confirmation"}))
    |> repo.transaction()
  end

end
