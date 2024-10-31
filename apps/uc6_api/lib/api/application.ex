defmodule EHCS.UC6.API.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EHCS.UC6.API.Telemetry,
      EHCS.UC6.API.Endpoint
    ]

    opts = [strategy: :one_for_one, name: EHCS.UC6.API.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    EHCS.UC6.API.Endpoint.config_change(changed, removed)
    :ok
  end
end
