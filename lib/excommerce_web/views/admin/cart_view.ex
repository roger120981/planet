defmodule ExcommerceWeb.Admin.CartView do
  use ExcommerceWeb, :view

  # This will depend on preload ??
  # We should actually look at whether product has product option types
  # This can lead to incorrect variant additions in corrupted data
  # We might have to disallow such products in listing and addition too
  def only_master_variant?(%Excommerce.Catalog.Product{variants: [], master: _master}), do: true
  def only_master_variant?(%Excommerce.Catalog.Product{variants: [_]}), do: true
  def only_master_variant?(%Excommerce.Catalog.Product{variants: [_|_]}), do: false

  def out_of_stock?(%Excommerce.Catalog.Variant{} = variant), do: Excommerce.Catalog.Variant.available_quantity(variant) == 0

  def product_variant_options(%Excommerce.Catalog.Product{} = product) do
    Enum.map(product.variants, fn
      (%Excommerce.Catalog.Variant{is_master: true}) -> "" # Do not add master variant to product list
      (variant) ->
        content_tag(:option, value: variant.id, disabled: out_of_stock?(variant)) do
          ExcommerceWeb.Admin.VariantView.variant_options_text(variant)
          <> if out_of_stock?(variant) do
            "(Out of stock)"
          else
            ""
          end
        end
    end)
  end

  def master_variant_id(%Excommerce.Catalog.Product{variants: [master_variant]}), do: master_variant.id

end
