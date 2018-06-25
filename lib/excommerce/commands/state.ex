defmodule Excommerce.Command.State do
  use Excommerce.Command, schema: Excommerce.Addresses.State

  def insert_for_country(repo, country, params) do
    country
    |> Ecto.build_assoc(:states)
    |> Excommerce.Addresses.State.changeset(params)
    |> repo.insert
  end
end
