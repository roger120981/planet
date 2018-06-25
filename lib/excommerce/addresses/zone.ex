defmodule Excommerce.Addresses.Zone do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Addresses.{Zone, ZoneMember}

  schema "zones" do
    field :name, :string
    field :description, :string
    field :type, :string

    has_many :country_zone_members, {"country_zone_members", ZoneMember}, on_replace: :delete
    has_many :state_zone_members, {"state_zone_members", ZoneMember}

    timestamps()
    
  end

  @required_fields ~w(name description type)a
  @optional_fields ~w()a

  @zone_types ~w(Country State)

  def changeset(zone, attrs \\ %{}) do
    zone
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:type, @zone_types)
  end

  def zone_types, do: @zone_types

end
