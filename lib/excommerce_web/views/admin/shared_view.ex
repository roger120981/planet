defmodule ExcommerceWeb.Admin.SharedView do
  use ExcommerceWeb, :view

  def active_on_current(%{request_path: path}, path), do: "active"
  def active_on_current(_, _), do: nil

  def selected_on_current(%{request_path: path}, path), do: "selected"
  def selected_on_current(_, _), do: nil

end
