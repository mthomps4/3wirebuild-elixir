# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :wirebuild,
  ecto_repos: [Wirebuild.Repo]

# Configures the endpoint
config :wirebuild, WirebuildWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WW3Q1O83QofgRnqD1fSpJQMvtmTibKoZa+nIHQ5l274m+7poJTew7XMNG3X3BiuJ",
  render_errors: [view: WirebuildWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Wirebuild.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :wirebuild, Wirebuild.Account.Guardian,
  issuer: "wirebuild_api",
  secret_key: "phNYS0GAoLq2Xoa9qNEf6lCD9AtZB5SSvWJlOhH0X4vScRaXz6hM90iF52T6F30f"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
