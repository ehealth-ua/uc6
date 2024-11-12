defmodule EHCS.UC6.Prescriptions do
  import Ecto.Query

  alias Ecto.Multi
  alias EHCS.UC6.Prescription
  alias EHCS.UC6.Repo

  def search(tax_id \\ nil, limit \\ 100, offset \\ 0) do
      query = order_by(Prescription, desc: :created_at)
      query = case tax_id do
        nil -> query
        _ -> where(query, rnokpp: ^tax_id)
      end
      query |> limit(^limit) |> offset(^offset) |> Repo.all()
  end

  def get_prescription(id) do
      result = Repo.get(Prescription, id)
      case result do
        nil -> {:error, :prescription_not_found}
        _ -> {:ok, result}
      end
  end

  def create_pending(tax_id, unzr, patient_name, patient_age) do
      Prescription.create_pending(tax_id, unzr, patient_name, patient_age) |> Repo.insert()
  end

  def create_pending(%Multi{} = multi, tax_id, unzr, patient_name, patient_age) do
      multi |> Multi.insert(:prescriptions,
        Prescription.create_pending(tax_id, unzr, patient_name, patient_age))
  end

  def change_status(%Prescription{} = prescription, status) do
      Prescription.change_status(prescription, status) |> Repo.update()
  end

  def change_status(%Multi{} = multi, %Prescription{} = prescription, status) do
      multi |> Multi.update(:prescription, Prescription.change_status(prescription, status))
  end
end
