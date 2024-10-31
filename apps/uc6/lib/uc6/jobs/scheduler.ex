defmodule EHCS.UC6.Jobs.Scheduler do
  alias EHCS.UC6.Jobs.PushMessageStatusRefresh
  alias Ecto.Multi

  def schedule_push_message_status_refresh(%Multi{} = multi, schedule_in, push_message_id)
      when is_binary(push_message_id) do
    multi
    |> Oban.insert(
      :job,
      PushMessageStatusRefresh.new(
        %{push_message_id: push_message_id},
        schedule_in: schedule_in
      )
    )
  end

  def schedule_push_message_status_refresh(%Multi{} = multi, schedule_in, push_message_id_fun)
      when is_function(push_message_id_fun) do
    multi
    |> Oban.insert(
      :job,
      fn changes ->
        push_message_id = push_message_id_fun.(changes)

        PushMessageStatusRefresh.new(
          %{push_message_id: push_message_id},
          schedule_in: schedule_in
        )
      end
    )
  end
end
