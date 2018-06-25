defmodule ExcommerceWeb.CartManager do
  
  alias Excommerce.Orders.Order
  alias Excommerce.Catalog.Variant
  alias Excommerce.Repo

  def count_items_in_cart(%Order{} = order) do
    Enum.reduce(order.line_items, 0, &(&1.quantity + &2))
  end

  def add_to_cart(_, %{"variant_id" => nil}) do
    {:error, %Ecto.Changeset{errors: [variant: "can't be blank"]}}
  end

  def add_to_cart(%Excommerce.Orders.Order{} = order, %{"variant_id" => variant_id, "quantity" => quantity}) do
    variant = Excommerce.Query.Variant.get!(Repo, variant_id) |> Repo.preload([:product])
    do_add_to_cart(order, variant, quantity)
  end

  def add_to_cart(order_id, %{"variant_id" => variant_id, "quantity" => quantity}) do
    order = Repo.get!(Order, order_id)
    variant = Excommerce.Query.Variant.get!(Repo, variant_id) |> Repo.preload([:product])
    do_add_to_cart(order, variant, quantity)
  end

  defp do_add_to_cart(%Order{} = order, %Variant{} = variant, quantity) do
    line_item = Excommerce.Query.LineItem.in_order_with_variant(Repo, order, variant)

    update_result =
      case line_item do
        nil ->
          ExcommerceWeb.Workflow.AddNewItemToCart.run(Repo, variant, order, quantity)
        line_item ->
          ExcommerceWeb.Workflow.UpdateQuantityInCart.run(Repo, line_item, variant, quantity)
      end
    process_update(update_result)
  end

  defp process_update({:ok, update_result}),
    do: {:ok, update_result[:line_item]}

  defp process_update({:error, _name, message, _result}),
    do: {:error, message}

end
