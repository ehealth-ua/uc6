defmodule EHCS.XmlSerializer do
  import SweetXml

  alias XmlBuilder
  alias EHCS.XmlSerializer.Schema

  @spec serialize(term(), Schema.t(), keyword()) :: binary()
  def serialize(data, schema, opts \\ [])

  def serialize(data, schema, opts) when is_atom(schema) do
    element = schema.element()
    element_schema = schema.schema()
    namespaces = schema.namespaces()
    serialize(data, {element, element_schema, namespaces}, opts)
  end

  def serialize(data, {element, schema}, opts) do
    serialize(data, {element, schema, []}, opts)
  end

  def serialize(data, {element, element_schema, namespaces}, opts) do
    build_element(data, {:element, element, element_schema})
    |> add_namespaces(namespaces)
    |> document(opts)
    |> XmlBuilder.generate()
  end

  @spec deserialize(binary(), Schema.t(), keyword()) :: term()
  def deserialize(xml, schema, opts \\ [])

  def deserialize(xml, schema, opts) when is_atom(schema) do
    element = schema.element()
    element_schema = schema.schema()
    namespaces = schema.namespaces()
    deserialize(xml, {element, element_schema, namespaces}, opts)
  end

  def deserialize(xml, {element, element_schema}, opts) do
    deserialize(xml, {element, element_schema, []}, opts)
  end

  def deserialize(xml, {element, element_schema, namespaces}, _opts) do
    xml
    |> parse(namespace_conformant: true)
    |> parse_element({:element, element, element_schema}, namespaces)
  end

  defp document(element, opts) do
    case opts[:document] do
      true -> XmlBuilder.document(element)
      _ -> element
    end
  end

  defp build_element(data, {:element, name, :string}) when is_binary(data) do
    XmlBuilder.element(name, data)
  end

  defp build_element(data, {:element, name, [{:element, _, _} = meta]})
       when is_list(data) do
    XmlBuilder.element(
      name,
      Enum.map(data, fn item -> build_element(item, meta) end)
    )
  end

  defp build_element(data, {:element, name, schema})
       when is_map(data) and is_map(schema) do
    attributes =
      schema
      |> Enum.filter(fn {_, meta} -> elem(meta, 0) == :attribute end)
      |> Enum.map(fn {field, meta} -> build_attribute(data[field], meta) end)

    elements =
      schema
      |> Enum.filter(fn {_, meta} -> elem(meta, 0) == :element end)
      |> Enum.filter(fn {field, _} -> data[field] != nil end)
      |> Enum.map(fn {field, meta} -> build_element(data[field], meta) end)
      |> Enum.sort_by(fn {elem_name, _, _} -> elem_name end)

    XmlBuilder.element(name, attributes, elements)
  end

  defp build_attribute(data, {:attribute, name, :string}) when is_binary(data) do
    {name, data}
  end

  defp parse_element(nil, _, _), do: nil

  defp parse_element(element, {:element, name, :string}, namespaces) do
    case xpath(element, ~x"//#{name}/text()"o |> add_namespaces(namespaces)) do
      nil -> nil
      charlist -> to_string(charlist)
    end
  end

  defp parse_element(element, {:attribute, name, :string}, namespaces) do
    case xpath(element, ~x"//@#{name}"o |> add_namespaces(namespaces)) do
      nil -> nil
      charlist -> to_string(charlist)
    end
  end

  defp parse_element(
         container,
         {:element, container_name, [{:element, name, _} = meta]},
         namespaces
       ) do
    container
    |> xpath(~x"//#{container_name}/#{name}"l |> add_namespaces(namespaces))
    |> Enum.map(fn element -> parse_element(element, meta, namespaces) end)
  end

  defp parse_element(element, {:element, name, schema}, namespaces) when is_map(schema) do
    schema
    |> Enum.map(fn {field, meta} ->
      {field,
       parse_element(
         xpath(element, ~x"//#{name}" |> add_namespaces(namespaces)),
         meta,
         namespaces
       )}
    end)
    |> Map.new()
  end

  defp add_namespaces({name, [], content} = element, namespaces) do
    case namespaces do
      [] ->
        element

      _ ->
        XmlBuilder.element(
          name,
          Enum.map(namespaces, fn {prefix, uri} -> {:"xmlns:#{prefix}", uri} end),
          content
        )
    end
  end

  defp add_namespaces(%SweetXpath{} = xpath, namespaces) do
    Enum.reduce(namespaces, xpath, fn {prefix, uri}, result ->
      add_namespace(result, prefix, uri)
    end)
  end
end
