defmodule EHCS.UC6.Jobs.PrescriptionStatusRefresh do
  require Logger

  alias Oban.Worker
  alias Oban.Job

  use Worker, queue: :prescrtiption_status

  @impl true
  def perform(%Job{args: %{"prescription_id" => _prescription_id}}) do
      :ok
  end
end
