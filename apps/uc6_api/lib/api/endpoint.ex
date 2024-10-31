defmodule EHCS.UC6.API.Endpoint do
  use Phoenix.Endpoint, otp_app: :uc6_api

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug EHCS.UC6.API.Router
end
