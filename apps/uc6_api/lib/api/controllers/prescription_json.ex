defmodule EHCS.UC6.API.PushMessageJSON do
  def create(%{prescription: prescription}) do
    project(prescription)
  end

  def show(%{prescription: prescription}) do
    project(prescription)
  end

  defp project(prescription) do
    %{
      id: prescription.id,
      patient_ud: prescription.unzr,
      status: prescription.status
    }
  end
end
