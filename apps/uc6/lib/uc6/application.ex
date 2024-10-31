defmodule EHCS.UC6.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EHCS.UC6.Repo,
      {Oban, Application.fetch_env!(:uc6, Oban)}
    ]

    opts = [strategy: :one_for_one, name: EHCS.UC6.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
