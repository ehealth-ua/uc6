defmodule EHCS.UC6.API.PushMessageJSON do
  def create(%{push_message: push_message}) do
    project(push_message)
  end

  def show(%{push_message: push_message}) do
    project(push_message)
  end

  defp project(push_message) do
    %{
      id: push_message.id,
      person_id: push_message.person_id,
      status: push_message.status
    }
  end
end
