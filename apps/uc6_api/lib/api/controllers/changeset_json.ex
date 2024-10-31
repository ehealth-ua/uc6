defmodule EHCS.UC6.API.ChangesetJSON do
  alias Ecto.Changeset

  def error(%{changeset: changeset}) do
    %{
      type: :validation,
      message: "Validation error",
      errors: traverse_errors(changeset)
    }
  end

  defp traverse_errors(changeset) do
    Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts
        |> Keyword.get(String.to_existing_atom(key), key)
        |> to_string()
      end)
    end)
  end
end
