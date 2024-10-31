defmodule EHCS.UC6.API.FallbackController do
  require Logger

  use EHCS.UC6.API, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(422)
    |> put_view(EHCS.UC6.API.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :template_not_found, template_name}) do
    conn
    |> put_status(400)
    |> put_view(EHCS.UC6.API.ErrorJSON)
    |> render(
      :"400",
      type: :template_not_found,
      message: "Template \"#{template_name}\" not found"
    )
  end

  def call(conn, _) do
    conn
    |> put_status(500)
    |> put_view(EHCS.UC6.API.ErrorJSON)
    |> render(:"500")
  end
end
