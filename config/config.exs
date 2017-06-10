# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :bravado, Bravado.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IOCquZgjy4wDWh54O0BzwnjHkXqLfspiU8VcAPneOj00eeLb0qi1pPgP1zH44UHt",
  render_errors: [view: Bravado.Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: Bravado.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Rate limiter
config :bravado, max_rate_limit_per_minute: 5


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
