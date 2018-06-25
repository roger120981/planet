defmodule Excommerce.Mixfile do
  use Mix.Project

  def project do
    [
      app: :excommerce,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Excommerce.Application, []},
      extra_applications: [:logger, :runtime_tools, :scrivener_ecto]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:phauxth, "~> 1.2"},
      {:bcrypt_elixir, "~> 1.0"},
      {:bamboo, "~> 0.8"},
      {:arc_ecto, "~> 0.7.0"},
      {:timex, "~> 3.0"},
      {:timex_ecto, "~> 3.0"},
      {:liquid, "~> 0.8.0"},
      {:mime, "~> 1.1"},
      {:worldly, "~> 0.1.2"},
      {:scrivener_ecto, "~> 1.0"},
      {:scrivener_html, "~> 1.7.1"},
      {:commerce_billing, github: "nimish-mehta/commerce_billing", override: true},
      {:poison, "~> 3.1", override: true},
      {:yamerl, github: "yakaz/yamerl"},
      {:braintree, "~> 0.5.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
