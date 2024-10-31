defmodule EHCS.UC6.Trembita do
  require Logger

  alias EHCS.UC6.Trembita.NotificationStatus
  alias EHCS.UC6.Trembita.DistributionStatus
  alias EHCS.UC6.Trembita.CreateNotification
  alias EHCS.Trembita

  @behaviour EHCS.UC6.Trembita.Behaviour

  def debug(envelope, action) do
    response =
      HTTPoison.post(
        option!(:endpoint),
        envelope,
        [
          {"Content-Type", "text/xml;charset=utf-8"},
          {"SOAPAction", action}
        ]
      )

    case response do
      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.info("Trembita http error", reason: reason)
        {:error, reason}

      {:ok, %HTTPoison.Response{body: body, status_code: status_code}} ->
        Logger.info("Trembita response received", status_code: status_code)
        {:ok, body}
    end
  end

  @impl true
  def create_notification(parameters) do
    request = %{
      partner_id: option!(:partner_id),
      template_id: parameters.template_id,
      recipients:
        parameters.recipient_notifications
        |> Enum.map(fn n ->
          %{
            id: n.recipient_id,
            rnokpp: n.tax_id,
            parameters: n.parameters
          }
        end)
    }

    with {:ok, response} <- Trembita.call(CreateNotification, request) do
      case response do
        %{error: error} when is_binary(error) ->
          {:error, error}

        %{distribution_id: distribution_id} when is_binary(distribution_id) ->
          {:ok, %{distribution_id: distribution_id}}
      end
    end
  end

  @impl true
  def distribution_status(distribution_id) do
    request = %{
      partner_id: option!(:partner_id),
      distribution_id: distribution_id
    }

    with {:ok, response} <- Trembita.call(DistributionStatus, request) do
      case response do
        %{error: error} when is_binary(error) ->
          {:error, error}

        %{status: status} when is_binary(status) ->
          {:ok, %{status: cast_distibution_status(status)}}
      end
    end
  end

  @impl true
  def notification_status(distribution_id) do
    request = %{
      partner_id: option!(:partner_id),
      distribution_id: distribution_id
    }

    with {:ok, response} <- Trembita.call(NotificationStatus, request) do
      case response do
        %{error: error} when is_binary(error) ->
          {:error, error}

        %{recipients: recipients} ->
          result =
            Enum.map(recipients, fn r ->
              %{
                recipient_id: r.id,
                status: aggregate_recipient_status(r.devices)
              }
            end)

          {:ok, %{recipient_notifications: result}}
      end
    end
  end

  defp cast_distibution_status(status) do
    case status do
      "pending" -> :pending
      "in-progress" -> :in_progress
      "sent" -> :sent
      "closed" -> :closed
    end
  end

  defp aggregate_recipient_status(devices) do
    cond do
      any_device_status?(devices, "read") ->
        :read

      any_device_status?(devices, "sent") ->
        :sent

      any_device_status?(devices, "notification-generation-error") ->
        :notification_generation_error

      any_device_status?(devices, "send-error") ->
        :send_error

      any_device_status?(devices, "not-found") ->
        :not_found
    end
  end

  def any_device_status?(devices, status) do
    Enum.any?(devices, fn d -> d.status == status end)
  end

  defp options do
    Application.get_env(:uc6, __MODULE__, [])
  end

  defp option!(key) do
    Keyword.fetch!(options(), key)
  end
end
