defmodule EHCS.UC6.API.FallbackController do
  require Logger

  use EHCS.UC6.API, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(422)
    |> put_view(EHCS.UC6.API.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :prescription_not_found, prescription}) do
    conn
    |> put_status(400)
    |> put_view(EHCS.UC6.API.ErrorJSON)
    |> render(
      :"400",
      type: :prescription_not_found,
      message: "Prescription \"#{prescription}\" not found"
    )
  end

  def call(conn, _) do
    conn
    |> put_status(500)
    |> put_view(EHCS.UC6.API.ErrorJSON)
    |> render(:"500")
  end
end
