defmodule EHCS.UC6.API.PrescriptionController do
  use EHCS.UC6.API, :controller

  alias EHCS.UC6.API.PrescriptionRequest
  alias EHCS.UC6.API.FallbackController
  alias EHCS.UC6

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, r} <- PrescriptionRequest.cast(params),
         {:ok, prescription} <- UC6.send_prescription(r.prescription_id, r.tax_id, r.title, r.patient_name) do
      conn |> put_status(201)
           |> render(:create, prescription: prescription)
    end
  end

  def get(conn, %{"id" => id}) do
    with {:ok, prescription} <- UC6.get_prescription(id) do
      conn |> put_status(200)
           |> render(:show, prescription: prescription)
    end
  end
end
