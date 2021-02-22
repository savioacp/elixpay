# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixpay,
  ecto_repos: [Elixpay.Repo]

# Configures the endpoint
config :elixpay, ElixpayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Rj0UwqsfXMO8DVMTtTdy0l6lwcc65XQKT+hWdhaYzHOsGdyxgRUl8RhuD9LhI2qm",
  render_errors: [view: ElixpayWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Elixpay.PubSub,
  live_view: [signing_salt: "Kcm6CLiQ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
