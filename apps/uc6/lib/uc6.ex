defmodule EHCS.UC6 do
  require Logger
  alias EHCS.UC6.PushMessages

  def get_push_message(push_message_id) when is_binary(push_message_id) do
    PushMessages.get_push_message(push_message_id)
  end

  def search(tax_id \\ nil, limit \\ 100, offset \\ 0) do
    PushMessages.search(tax_id, limit, offset)
  end

  def send_push_message(person_id, tax_id, title, summary, message) do
      :ok
  end

end
