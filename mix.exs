defmodule EHCS.UC6.Umbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        uc6_api: [
          include_executables_for: [:unix],
          applications: [uc6_api: :permanent]
        ],
        uc6_worker: [
          include_executables_for: [:unix],
          applications: [uc6_worker: :permanent]
        ]
      ]
    ]
  end

  defp deps do
    []
  end
end
