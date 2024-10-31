defmodule EHCS.UC6.Jobs.PushMessageStatusRefresh do
  require Logger

  alias Oban.Worker
  alias Oban.Job

  use Worker, queue: :push_message_status

  @impl true
  def perform(%Job{args: %{"push_message_id" => _push_message_id}}) do
      :ok
  end
end
