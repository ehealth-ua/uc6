defmodule EHCS.UC6.Jobs.Scheduler do
  alias EHCS.UC6.Jobs.PrescriptionStatusRefresh
  alias Ecto.Multi

  def schedule_prescription_status_refresh(%Multi{} = multi, schedule_in, prescription_id)
      when is_binary(prescription_id) do
    multi
    |> Oban.insert(
      :job,
      PrescriptionStatusRefresh.new(
        %{prescription_id: prescription_id},
        schedule_in: schedule_in
      )
    )
  end

  def schedule_prescription_status_refresh(%Multi{} = multi, schedule_in, prescription_id_fun)
      when is_function(prescription_id_fun) do
    multi
    |> Oban.insert(
      :job,
      fn changes ->
        prescription_id = prescription_id_fun.(changes)

        PrescriptionStatusRefresh.new(
          %{prescription_id: prescription_id},
          schedule_in: schedule_in
        )
      end
    )
  end
end
