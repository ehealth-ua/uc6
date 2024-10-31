defmodule EHCS.UC6.API.PushMessageController do
  use EHCS.UC6.API, :controller

  alias EHCS.UC6.API.PushMessageRequest
  alias EHCS.UC6.API.FallbackController
  alias EHCS.UC6

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, request} <- PushMessageRequest.cast(params),
         {:ok, push_message} <-
           UC6.send_push_message(
             request.person_id,
             request.tax_id,
             request.title,
             request.summary,
             request.message
           ) do
      conn
      |> put_status(201)
      |> render(:create, push_message: push_message)
    end
  end

  def get(conn, %{"id" => id}) do
    with {:ok, push_message} <- UC6.get_push_message(id) do
      conn
      |> put_status(200)
      |> render(:show, push_message: push_message)
    end
  end
end
