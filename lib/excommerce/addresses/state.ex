defmodule Excommerce.Addresses.State do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Addresses.{Country, ZoneMember}

  schema "states" do
    field :abbr, :string
    field :name, :string

    belongs_to :country, Country

    has_many :zone_members, {"state_zone_members", ZoneMember}, foreign_key: :zoneable_id
    has_many :zones, through: [:zone_members, :zone]

    timestamps()
    
  end

  @required_fields ~w(name abbr country_id)a
  @optional_fields ~w()a

  def changeset(country, attrs \\ %{}) do
    country
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:country_id)
  end
end
