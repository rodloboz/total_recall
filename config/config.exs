# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :total_recall,
  ecto_repos: [TotalRecall.Repo]

# Configures the endpoint
config :total_recall, TotalRecallWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "f61KFWoQh3i/8uez6NovdibA8uRAl4lQkxdYc6AwrQ54iAESpu5AQMxQicSm2LEV",
  render_errors: [view: TotalRecallWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TotalRecall.PubSub,
  live_view: [signing_salt: "lm0yKexF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
