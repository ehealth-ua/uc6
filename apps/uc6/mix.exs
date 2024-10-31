defmodule EHCS.UC6.MixProject do
  use Mix.Project

  def project do
    [
      app: :uc6,
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
      mod: {EHCS.UC6.Application, []}
    ]
  end

  defp deps do
    [
      {:trembita, in_umbrella: true},
      {:ecto_sql, "~> 3.0"},
      {:ehealth_logger, github: "edenlabllc/ehealth_logger"},
      {:httpoison, "~> 2.0"},
      {:postgrex, ">= 0.0.0"},
      {:oban, "~> 2.17"},
      {:sweet_xml, "~> 0.7.1"},
      {:uuid, "~> 1.1" },
      {:xml_builder, "~> 2.1"}
    ]
  end
end
