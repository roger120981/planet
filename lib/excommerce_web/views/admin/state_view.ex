defmodule ExcommerceWeb.Admin.StateView do
  use ExcommerceWeb, :view

  def render("state.json", %{state: state}) do
    %{id: state.id, name: state.name, abbr: state.abbr}
  end
end
