defmodule Excommerce.Query.User do
  use Excommerce.Query, schema: Excommerce.Accounts.User

  def current_order(repo, user) do
    repo.one(
      from order in all_abandoned_orders(user),
      order_by: [desc: order.updated_at],
      limit: 1
    )
  end

  def all_abandoned_orders(%Excommerce.Accounts.User{} = user) do
    from order in all_orders(user),
      where: not(order.state == "confirmation")
  end

  def all_orders(%Excommerce.Accounts.User{id: id}) do
    from o in Excommerce.Orders.Order,
      where: o.user_id == ^id
  end

  def all_abandoned_orders(repo, user), do: repo.all(all_abandoned_orders(user))

end
