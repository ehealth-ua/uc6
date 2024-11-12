defmodule EHCS.UC6.Repo.Migrations.AddPrescriptions do
  use Ecto.Migration

  def change do
    create table("prescriptions", primary_key: false) do
      add :id, :string, primary_key: true
      add :rnokpp, :string, null: false
      add :unzr, :string, null: false
      add :request_number, :string, null: false
      add :created_at, :naive_datetime_usec, null: false
      add :changed_at, :naive_datetime_usec, null: false
      add :dispende_valid_from, :naive_datetime_usec, null: false
      add :status, :string, null: false
      add :patient_name, :string, null: false
      add :patient_age, :string, null: false
      add :medicine, :string, null: false
      add :medication_qty, :string, null: false
      add :dosage_instruction, :string, null: false
      add :sign, :string, null: false
    end
  end
end
