defmodule Excommerce.Command.LineItem do
  use Excommerce.Command, schema: Excommerce.Orders.LineItem

  import Ecto.Query
  def set_shipment_unit(repo, line_item_ids, shipment_unit_id) do
    q =
      from line_item in Excommerce.Orders.LineItem,
        where:  line_item.id in ^line_item_ids,
        update: [set: [shipment_unit_id: ^shipment_unit_id]]
    repo.update_all(q, [])
  end
end
