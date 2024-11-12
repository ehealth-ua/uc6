defmodule EHCS.UC6 do
  require Logger
  alias EHCS.UC6.Prescriptions

  def get_prescription(prescription_id) when is_binary(prescription_id) do Prescriptions.get_prescription(prescription_id) end
  def search(tax_id \\ nil, limit \\ 100, offset \\ 0) do Prescriptions.search(tax_id, limit, offset) end
  def send_prescription(prescription_id, tax_id, patient_name) do :ok end

end
