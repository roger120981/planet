defmodule Excommerce.Settings do
  @moduledoc """
  The Settings context.
  """

  import Ecto.Query, warn: false

  alias Excommerce.Repo
  alias Excommerce.Settings.Setting

  def get_settings() do
    if settings = Repo.all(Setting, limit: 1) do
      settings
      |> Enum.at(0)
      |> Repo.preload(:theme)
    end
  end

  def create_settings(attrs \\ %{}) do
    %Setting{}
    |> Setting.changeset(attrs)
    |> Repo.insert()
  end

  def update_settings(%Setting{} = setting, attrs) do
    setting
    |> Setting.changeset(attrs)
    |> Repo.update()
  end

  def delete_settings(%Setting{} = setting) do
    Repo.delete(setting)
  end

  def change_settings(%Setting{} = setting), do: Setting.changeset(setting, %{})
end
