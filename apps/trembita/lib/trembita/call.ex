defmodule EHCS.Trembita.Call do
  @callback request() :: module()

  @callback response() :: module()

  @callback member_class() :: binary()

  @callback member_code() :: binary()

  @callback subsystem_code() :: binary()

  @callback service_code() :: binary()

  defmacro __using__(opts) do
    expanded = Macro.expand(opts, __CALLER__)

    quote do
      @behaviour EHCS.Trembita.Call

      @impl true
      def request, do: Keyword.fetch!(unquote(expanded), :request)

      @impl true
      def response, do: Keyword.fetch!(unquote(expanded), :response)

      @impl true
      def member_class, do: Keyword.fetch!(unquote(expanded), :member_class)

      @impl true
      def member_code, do: Keyword.fetch!(unquote(expanded), :member_code)

      @impl true
      def subsystem_code, do: Keyword.fetch!(unquote(expanded), :subsystem_code)

      @impl true
      def service_code, do: Keyword.fetch!(unquote(expanded), :service_code)
    end
  end
end
