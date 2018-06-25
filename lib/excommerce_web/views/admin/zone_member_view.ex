defmodule ExcommerceWeb.Admin.ZoneMemberView do
  use ExcommerceWeb, :view

  def render("zone_member.json", %{zone_member: zone_member, zoneable: zoneable}) do
    %{id: zone_member.id, name: zoneable.name, zoneable_id: zoneable.id}
  end

  def render("zoneable.json", %{zoneable: zoneable}) do
    %{id: zoneable.id, name: zoneable.name}
  end

  def render("success.json", _) do
    %{success: "ok"}
  end
end
