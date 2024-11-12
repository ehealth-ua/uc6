defmodule EHCS.Trembita.MixProject do
  use Mix.Project

  def project do
    [
      app: :trembita,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:uuid, "~> 1.1"},
      {:xml_serializer, in_umbrella: true}
    ]
  end
end
