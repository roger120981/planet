defmodule ExcommerceWeb.ProductView do
  use ExcommerceWeb, :view

  defdelegate only_master_variant?(product), to: ExcommerceWeb.Admin.CartView

  def product_variant_options(%Excommerce.Catalog.Product{} = product) do
    Enum.map(product.variants, fn(variant) ->
      {variant_name(variant), variant.id}
    end)
  end

  defp out_of_stock?(variant) do
    Excommerce.Catalog.Variant.available_quantity(variant) == 0
  end

  def variant_name(variant) do
    ExcommerceWeb.Admin.VariantView.variant_options_text(variant)
    <> if out_of_stock?(variant) do
      " (out of stock)"
    else
      ""
    end
  end

end
