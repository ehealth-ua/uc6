import Config

config :uc6, EHCS.UC6.Repo, pool: Ecto.Adapters.SQL.Sandbox

config :uc6_api, EHCS.UC6.API.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "HsV9iXTbQikkr/oNStXVt5SBM0dFhQaVQE+1vMlP6h4PUj02bpY/sonzvPgCcjt+",
  server: false,
  secret_key_base: "HsV9iXTbQikkr/oNStXVt5SBM0dFhQaVQE+1vMlP6h4PUj02bpY/sonzvPgCcjt+"
