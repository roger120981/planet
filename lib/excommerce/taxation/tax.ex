defmodule Excommerce.Taxation.Tax do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Excommerce.Taxation.Tax

  schema "taxes" do
    field :name

    timestamps()
    
  end

  @optional_fields ~w()a
  @required_fields ~w(name)a

  def changeset(tax, attrs \\ %{}) do
    tax
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

end
