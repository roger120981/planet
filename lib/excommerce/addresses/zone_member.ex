defmodule Excommerce.Addresses.ZoneMember do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Addresses.{Zone, ZoneMember}

  schema "abstract table:zone_members" do
    field :zoneable_id, :integer
    belongs_to :zone, Zone

    timestamps()
    
  end

  @required_fields ~w(zoneable_id zone_id)a
  @optional_fields ~w()a

  def changeset(zone_member, attrs \\ %{}) do
    zone_member
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

end
