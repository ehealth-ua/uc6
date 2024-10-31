defmodule EHCS.Trembita do
  alias UUID
  alias EHCS.XmlSerializer
  alias EHCS.Trembita.Message

  @spec call(module(), term()) :: {:ok, term()} | {:error, term()}
  def call(call, params) do
    opts = opts()

    body =
      params
      |> message(call, opts)
      |> XmlSerializer.serialize(
        Message.schema(call.request()),
        document: true
      )

    response =
      HTTPoison.post(
        opts[:endpoint],
        body,
        [
          {"Content-Type", "text/xml;charset=utf-8"},
          {"SOAPAction", call.service_code()}
        ]
      )

    case response do
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}

      {:ok, %HTTPoison.Response{body: body}} ->
        message = XmlSerializer.deserialize(body, Message.schema(call.response()))
        {:ok, message.body.content}
    end
  end

  defp message(params, call, opts) do
    Message.new(
      opts[:user_id],
      opts[:xroad_instance],
      %{
        member_class: opts[:client][:member_class],
        member_code: opts[:client][:member_code],
        subsystem_code: opts[:client][:subsystem_code]
      },
      %{
        member_class: call.member_class(),
        member_code: call.member_code(),
        subsystem_code: call.subsystem_code(),
        service_code: call.service_code()
      },
      params,
      id: UUID.uuid4()
    )
  end

  defp opts do
    Application.get_env(:trembita, :globals, [])
  end
end
