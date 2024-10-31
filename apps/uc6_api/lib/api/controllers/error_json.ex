defmodule EHCS.UC6.API.ErrorJSON do
  def render("400.json", assigns) do
    %{
      type: :request_malformed,
      message: "Request mallformed"
    }
    |> put_type(assigns)
    |> put_message(assigns)
  end

  def render("500.json", assigns) do
    %{
      type: :internal_error,
      message: "Internal error"
    }
    |> put_type(assigns)
    |> put_message(assigns)
  end

  defp put_message(body, %{message: message}) do
    Map.put(body, :message, message)
  end

  defp put_message(body, _) do
    body
  end

  defp put_type(body, %{type: type}) do
    Map.put(body, :type, type)
  end

  defp put_type(body, _) do
    body
  end
end
