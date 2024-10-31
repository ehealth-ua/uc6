defmodule EHCS.UC6.Repo do
  use Ecto.Repo,
    otp_app: :uc6,
    adapter: Ecto.Adapters.Postgres
end
