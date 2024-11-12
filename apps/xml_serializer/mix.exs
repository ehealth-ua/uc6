defmodule EHCS.XmlSerializer.MixProject do
  use Mix.Project

  def project do
    [
      app: :xml_serializer,
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
      {:sweet_xml, "~> 0.7.1"},
      {:xml_builder, "~> 2.1"}
    ]
  end
end
