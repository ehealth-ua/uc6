defmodule EHCS.UC6.API.PrescriptionRequest do
  alias Ecto.Changeset
  alias Ecto.UUID

  @types %{
    prescription_id: UUID,
    tax_id: :string,
    patient_name: :string
  }

  def cast(params) do
    {%{}, @types}
    |> Changeset.cast(params, Map.keys(@types))
    |> Changeset.validate_required([:prescription_id, :tax_id, :patient_name])
    |> Changeset.apply_action(:cast)
  end
end
