# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :excommerce,
  ecto_repos: [Excommerce.Repo]

# Configures the endpoint
config :excommerce, ExcommerceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "maBXJztJ0H4B1QgDl+oUQFkB8OERyuCcl9qoHRpDoT2mnk4+G1XzABWGerU42rU8",
  render_errors: [view: ExcommerceWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Excommerce.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :arc,
  storage: Arc.Storage.Local

# Configure Liquid
config :liquid,
       file_system: {Excommerce.Themer.FileSystem, "priv/themes"}

config :scrivener_html,
       routes_helper: Excommerce.Router.Helpers
	   
config :worldly, :data_path, Path.join(Mix.Project.build_path, "lib/worldly/priv/data")	   

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
