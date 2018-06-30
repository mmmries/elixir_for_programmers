use Mix.Config


config :socket_gallows, SocketGallows.Endpoint,
  load_from_system_env: true,
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info

# Finally import the config/prod.secret.exs
# which should be versioned separately.
import_config "prod.secret.exs"
