defmodule EHCS.UC6.PushMessage do
  use Ecto.Schema

  alias Ecto.Changeset
  alias Ecto.UUID

  @primary_key {:id, UUID, autogenerate: true}
  schema "push_messages" do
    field(:tax_id, :string)
    field(:template_name, :string)
    field(:template_parameters, {:map, :string})
    field(:status, Ecto.Enum, values: [:pending, :sent, :read, :error])
    field(:distribution_id, :string)
    field(:created_at, :naive_datetime_usec)
    field(:status_timestamp, :naive_datetime_usec)
  end

  @expiration_period_seconds 300

  def create_pending(tax_id, template_name, template_parameters, distribution_id) do
    changeset(%__MODULE__{}, %{
      tax_id: tax_id,
      template_name: template_name,
      template_parameters: template_parameters,
      status: :pending,
      distribution_id: distribution_id,
      created_at: NaiveDateTime.utc_now(),
      status_timestamp: NaiveDateTime.utc_now()
    })
  end

  def change_status(%__MODULE__{} = push_message, status) do
    changeset(push_message, %{
      status: status,
      status_timestamp: NaiveDateTime.utc_now()
    })
  end

  def in_final_status?(%__MODULE__{} = push_message) do
    push_message.status in [:read, :error]
  end

  def expired?(%__MODULE__{} = push_message) do
    diff =
      NaiveDateTime.diff(
        push_message.status_timestamp,
        push_message.created_at
      )

    diff > @expiration_period_seconds
  end

  defp changeset(%__MODULE__{} = push_message, attrs = %{}) do
    push_message
    |> Changeset.change(attrs)
    |> Changeset.validate_required([
      :tax_id,
      :template_name,
      :template_parameters,
      :status,
      :distribution_id,
      :created_at,
      :status_timestamp
    ])
  end
end
