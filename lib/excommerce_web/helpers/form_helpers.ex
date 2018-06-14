defmodule ExcommerceWeb.FormHelpers do
  import Phoenix.HTML, only: [raw: 1]
  import ExcommerceWeb.ErrorHelpers

  def input_class(form, field) do
    if form.errors[field] do
      "form-control is-invalid"
    else
      "form-control"
    end
  end

  def input_errors(form, field) do
    if error = form.errors[field] do
      raw """
      <span class="invalid-feedback">
        #{translate_error(error)}
      </span>
      """
    end
  end
end
