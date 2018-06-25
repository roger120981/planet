defmodule Excommerce.Addresses.Country do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Addresses.{Country, State, ZoneMember}

  schema "countries" do
    field :name,       :string
    field :iso,        :string
    field :iso3,       :string
    field :iso_name,   :string
    field :numcode,    :string
    field :has_states, :boolean, default: false
    has_many :states, State
    # Country can belong to many Zone via zone members
    has_many :zone_members, {"country_zone_members", ZoneMember}, foreign_key: :zoneable_id

    has_many :zones, through: [:zone_members, :zone]

    timestamps()
  end

  @required_fields ~w(name iso3 iso has_states)a
  @optional_fields ~w(numcode iso_name)a

  def changeset(country, attrs \\ %{}) do
    country
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:iso,  is: 2)
    |> validate_length(:iso3, is: 3)
    |> unique_constraint(:iso)
    |> unique_constraint(:iso3)
    |> unique_constraint(:name)
    |> unique_constraint(:numcode)
    |> build_iso_name
  end

  defp build_iso_name(%{valid?: false} = changeset), do: changeset
  defp build_iso_name(changeset) do
    name = get_change(changeset, :name)
    if name do
      put_change(changeset, :iso_name, String.upcase(name))
    else
      changeset
    end
  end
end
