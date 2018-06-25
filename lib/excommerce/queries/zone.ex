defmodule Excommerce.Query.Zone do
  use Excommerce.Query, schema: Excommerce.Addresses.Zone
  import Ecto, only: [assoc: 2]

  def zoneable!(repo, %Excommerce.Addresses.Zone{type: "Country"} = _schema, zoneable_id) do
    repo.get!(Excommerce.Addresses.Country, zoneable_id)
  end

  def zoneable!(repo, %Excommerce.Addresses.Zone{type: "State"} = _schema, zoneable_id) do
    repo.get!(Excommerce.Addresses.State, zoneable_id)
  end

  def member_with_id(repo, %Excommerce.Addresses.Zone{type: "Country"} = schema, zone_member_id) do
    repo.one(from m in assoc(schema, :country_zone_members),
      where: m.id == ^zone_member_id)
  end

  def member_with_id(repo, %Excommerce.Addresses.Zone{type: "State"} = schema, zone_member_id) do
    repo.one(from m in assoc(schema, :state_zone_members),
      where: m.id == ^zone_member_id)
  end

  def zoneable_candidates(repo, %Excommerce.Addresses.Zone{type: "Country"} = schema) do
    existing_zoneable_ids = existing_zoneable_ids(repo, schema)
    repo.all(from c in Excommerce.Addresses.Country, where: not c.id in ^existing_zoneable_ids)
  end

  def zoneable_candidates(repo, %Excommerce.Addresses.Zone{type: "State"} = schema) do
    existing_zoneable_ids = existing_zoneable_ids(repo, schema)
    repo.all(from s in Excommerce.Addresses.State, where: not s.id in ^existing_zoneable_ids)
  end

  def member_ids_and_names(%Excommerce.Addresses.Zone{type: "Country"} = schema) do
    from v in assoc(schema, :country_zone_members),
    join: c in Excommerce.Addresses.Country, on: c.id == v.zoneable_id,
    select: {v.id, c.name}
  end

  def member_ids_and_names(%Excommerce.Addresses.Zone{type: "State"} = schema) do
    from v in assoc(schema, :state_zone_members),
    join: c in Excommerce.Addresses.State, on: c.id == v.zoneable_id,
    select: {v.id, c.name}
  end

  def member_ids_and_names(repo, schema) do
    repo.all(member_ids_and_names(schema))
  end

  def members(%Excommerce.Addresses.Zone{type: "Country"} = schema) do
    from v in assoc(schema, :country_zone_members)
  end

  def members(%Excommerce.Addresses.Zone{type: "State"} = schema) do
    from v in assoc(schema, :state_zone_members)
  end

  def members(repo, schema) do
    repo.all(members(schema))
  end

  defp existing_zoneable_ids(%Excommerce.Addresses.Zone{type: "State"} = schema) do
    from cz in assoc(schema, :state_zone_members), select: cz.zoneable_id
  end

  defp existing_zoneable_ids(%Excommerce.Addresses.Zone{type: "Country"} = schema) do
    from cz in assoc(schema, :country_zone_members), select: cz.zoneable_id
  end

  defp existing_zoneable_ids(repo, schema) do
    repo.all(existing_zoneable_ids(schema))
  end

end
