defmodule Excommerce.Command.ZoneMember do
  use Excommerce.Command, schema: Excommerce.Addresses.ZoneMember

  def insert_for_zone(repo, zoneable, %Excommerce.Addresses.Zone{id: zone_id}) do
    zoneable
    |> Ecto.build_assoc(:zone_members)
    |> Excommerce.Addresses.ZoneMember.changeset(%{zone_id: zone_id})
    |> repo.insert
  end

end
