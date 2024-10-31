defmodule EHCS.UC6.PushMessages do
  import Ecto.Query

  alias Ecto.Multi
  alias EHCS.UC6.PushMessage
  alias EHCS.UC6.Repo

  def search(tax_id \\ nil, limit \\ 100, offset \\ 0) do
    query = order_by(PushMessage, desc: :created_at)

    query =
      case tax_id do
        nil -> query
        _ -> where(query, tax_id: ^tax_id)
      end

    query
    |> limit(^limit)
    |> offset(^offset)
    |> Repo.all()
  end

  def get_push_message(id) do
    result = Repo.get(PushMessage, id)

    case result do
      nil -> {:error, :push_message_not_found}
      _ -> {:ok, result}
    end
  end

  def create_pending(tax_id, template_name, template_parameters, distribution_id) do
    PushMessage.create_pending(
      tax_id,
      template_name,
      template_parameters,
      distribution_id
    )
    |> Repo.insert()
  end

  def create_pending(
        %Multi{} = multi,
        tax_id,
        template_name,
        template_parameters,
        distribution_id
      ) do
    multi
    |> Multi.insert(
      :push_message,
      PushMessage.create_pending(
        tax_id,
        template_name,
        template_parameters,
        distribution_id
      )
    )
  end

  def change_status(%PushMessage{} = push_message, status) do
    PushMessage.change_status(push_message, status)
    |> Repo.update()
  end

  def change_status(%Multi{} = multi, %PushMessage{} = push_message, status) do
    multi
    |> Multi.update(:push_message, PushMessage.change_status(push_message, status))
  end
end
