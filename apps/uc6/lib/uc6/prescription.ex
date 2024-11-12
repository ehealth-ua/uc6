defmodule EHCS.UC6.Prescription do
  use Ecto.Schema

  alias Ecto.Changeset
  alias Ecto.UUID

  @primary_key {:id, UUID, autogenerate: true}
  schema "prescriptions" do
    field(:request_number, :string)
    field(:status, Ecto.Enum, values: [:base, :active, :dispensed, :expired, :declined])
    field(:created_at, :naive_datetime_usec)
    field(:changed_at, :naive_datetime_usec)
    field(:dispense_valid_from, :string)
    field(:hospital_name, :string)
    field(:employee_name, :string)
    field(:patient_id, :string)
    field(:rnokpp, :string)
    field(:unzr, :string)
    field(:patient_name, :string)
    field(:patient_age, :string)
    field(:medicine, :string)
    field(:medication_qty, :string)
    field(:dosage_instruction, :string)
    field(:sign, :string)
  end

  @expiration_period_seconds 300

  def create_pending(tax_id, template_name, template_parameters, distribution_id) do
    changeset(%__MODULE__{}, %{
      rnokpp: tax_id,
      status: :pending,
      created_at: NaiveDateTime.utc_now(),
      changed_at: NaiveDateTime.utc_now(),
    })
  end

  def change_status(%__MODULE__{} = push_message, status) do
    changeset(push_message, %{
      status: status,
      changed_at: NaiveDateTime.utc_now()
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
      :rnokpp,
      :patient_name,
      :status,
      :created_at
    ])
  end
end
