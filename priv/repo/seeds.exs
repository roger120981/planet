# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Excommerce.Repo.insert!(%Excommerce.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Excommerce.Repo
alias Excommerce.Themes.Theme
alias Excommerce.Settings.Setting

theme = Theme.changeset(%Theme{alias: "planet", name: "Planet", description: "Tema por defecto para el proyecto Planet Security"}, %{})
{:ok, struct} = Repo.insert(theme)

setting = Setting.changeset(%Setting{theme_id: struct.id, website_title: "Esto es un sitio de ejemplo para Planet Security", website_description: "Planet Security Store"}, %{})
{:ok, result} = Repo.insert(setting)