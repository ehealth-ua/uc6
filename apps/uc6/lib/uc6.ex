defmodule EHCS.UC6 do
  require Logger
  alias EHCS.UC6.Prescriptions

  def get_prescription(prescription_id) when is_binary(prescription_id) do Prescriptions.get_prescription(prescription_id) end
  def search(tax_id \\ nil, limit \\ 100, offset \\ 0) do Prescriptions.search(tax_id, limit, offset) end
  def send_prescription(_id, _prescription_id, _tax_id, _patient_name) do :diia_trembita_channel end

end
