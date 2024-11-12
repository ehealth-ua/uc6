import Config

config :uc6,
  ecto_repos: [EHCS.UC6.Repo]

config :uc6, EHCS.UC6.Channel, trembita_client: EHCS.UC6.Trembita

config :uc6, Oban, repo: EHCS.UC6.Repo

config :uc6_api, EHCS.UC6.API.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: EHCS.UC6.API.ErrorJSON],
    layout: false
  ]

config :logger_json, :backend,
  formatter: EhealthLogger.Formatter,
  metadata: :all

config :logger,
  backends: [LoggerJSON],
  level: :info

config :logger, :console, metadata: :all

config :phoenix, :json_library, Jason

config :uc6_worker, Oban,
  name: EHCS.UC6.Worker.Oban,
  queues: [prescription_status: 10],
  repo: EHCS.UC6.Repo,
  plugins: [Oban.Plugins.Pruner]

import_config "#{config_env()}.exs"
