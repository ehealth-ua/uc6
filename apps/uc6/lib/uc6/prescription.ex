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

  def create_pending(unzr, tax_id, patient_name, patient_age) do
    changeset(%__MODULE__{}, %{
      rnokpp: tax_id,
      unzr: unzr,
      patient_name: patient_name,
      patient_age: patient_age,
      status: :pending,
      created_at: NaiveDateTime.utc_now(),
      changed_at: NaiveDateTime.utc_now(),
    })
  end

  def change_status(%__MODULE__{} = prescription, status) do
    changeset(prescription, %{
      status: status,
      changed_at: NaiveDateTime.utc_now()
    })
  end

  def in_final_status?(%__MODULE__{} = prescription) do
    prescription.status in [:read, :error]
  end

  def expired?(%__MODULE__{} = prescription) do
    diff =
      NaiveDateTime.diff(
        prescription.changed_at,
        prescription.created_at
      )

    diff > @expiration_period_seconds
  end

  defp changeset(%__MODULE__{} = prescription, attrs = %{}) do
    prescription
    |> Changeset.change(attrs)
    |> Changeset.validate_required([
      :rnokpp,
      :patient_name,
      :status,
      :created_at
    ])
  end
end
