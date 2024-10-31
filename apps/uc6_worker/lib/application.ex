defmodule EHCS.UC6.Worker.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Oban, Application.fetch_env!(:uc6_worker, Oban)}
    ]

    opts = [strategy: :one_for_one, name: EHCS.UC6.Worker.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
