defmodule EHCS.UC6.API.PushMessageRequest do
  alias Ecto.Changeset
  alias Ecto.UUID

  @types %{
    person_id: UUID,
    tax_id: :string,
    title: :string,
    summary: :string,
    message: :string
  }

  def cast(params) do
    {%{}, @types}
    |> Changeset.cast(params, Map.keys(@types))
    |> Changeset.validate_required([:person_id, :tax_id, :title, :summary, :message])
    |> Changeset.apply_action(:cast)
  end
end
