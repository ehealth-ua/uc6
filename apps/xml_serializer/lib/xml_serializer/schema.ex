defmodule EHCS.XmlSerializer.Schema do
  @type t :: {binary(), element_schema(), namespaces()} | {binary(), element_schema()} | module()

  @type element_schema :: :string | %{atom() => meta()} | %{binary() => meta()} | [meta()]

  @type attribute_schema :: :string

  @type meta :: element_meta() | attribute_meta()

  @type element_meta :: {:element, binary(), element_schema()}

  @type attribute_meta :: {:attribute, binary(), attribute_schema()}

  @type namespaces :: keyword(binary())

  @callback element() :: binary()

  @callback schema() :: element_schema()

  @callback namespaces() :: namespaces()

  defmacro __using__(opts) do
    expanded = Macro.expand(opts, __CALLER__)

    quote do
      @behaviour EHCS.XmlSerializer.Schema

      @impl true
      def element, do: Keyword.fetch!(unquote(expanded), :element)

      @impl true
      def schema, do: Keyword.fetch!(unquote(expanded), :schema)

      @impl true
      def namespaces, do: Keyword.get(unquote(expanded), :namespaces, [])
    end
  end
end
