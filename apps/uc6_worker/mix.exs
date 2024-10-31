defmodule EHCS.UC6.Worker.MixProject do
  use Mix.Project

  def project do
    [
      app: :uc6_worker,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {EHCS.UC6.Worker.Application, []}
    ]
  end

  defp deps do
    [
      {:uc6, in_umbrella: true}
    ]
  end
end
