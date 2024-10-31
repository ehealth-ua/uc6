defmodule EHCS.UC6.Trembita.Behaviour do
  @type notification_parameters :: %{
          template_id: binary(),
          recipient_notifications: [recipient_notification()]
        }

  @type recipient_notification :: %{
          recipient_id: binary(),
          tax_id: binary(),
          parameters: [
            %{
              key: binary(),
              value: binary()
            }
          ]
        }

  @type create_notification_result :: %{distribution_id: binary()}

  @type distribution_status_result :: %{status: distribution_status()}

  @type distribution_status :: :pending | :in_progress | :sent | :error

  @type notification_status_result :: %{
          recipient_notifications: [
            %{
              recipient_id: binary(),
              status: notification_status()
            }
          ]
        }

  @type notification_status ::
          :not_found | :sent | :send_error | :read | :notification_generation_error

  @callback create_notification(parameters :: notification_parameters()) ::
              {:ok, create_notification_result()} | {:error, term()}

  @callback distribution_status(distribution_id :: binary()) ::
              {:ok, %{status: distribution_status()}} | {:error, term()}

  @callback notification_status(distribution_id :: binary()) ::
              {:ok, notification_status_result()} | {:error, term()}
end
