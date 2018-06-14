defmodule ExcommerceWeb.Admin.OptionTypeView do
  use ExcommerceWeb, :view

  alias Excommerce.Catalog.{OptionType, OptionValue}

  def link_to_option_values_fields do
    changeset = OptionType.changeset(%OptionType{option_values: [%OptionValue{}]}, %{})
    form = Phoenix.HTML.FormData.to_form(changeset, [])
    fields = render_to_string(__MODULE__, "option_values.html", f: form)
    general_link_to "New Option Value", [to: "#", "data-template": fields, id: "add_option_value", class: "btn btn-success"]
  end
end
