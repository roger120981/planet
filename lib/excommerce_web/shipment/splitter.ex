defmodule ExcommerceWeb.Shipment.Splitter do

  alias ExcommerceWeb.Shipment.Splitter.DoNotSplit

  def split(order) do
    shipment_splitter = configured_shipment_splitter() || DoNotSplit
    shipment_splitter.split(order)
  end

  defp configured_shipment_splitter do
    Application.get_env(:excommerce, :shipment_splitter)
  end

end
