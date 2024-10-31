defmodule EHCS.Trembita.Message do
  @type t(content) :: %{
          header: header(),
          body: %{
            content: content
          }
        }

  @type header :: %{
          id: binary(),
          protocol_version: binary(),
          user_id: binary(),
          client: %{
            object_type: binary(),
            xroad_instance: binary(),
            member_class: binary(),
            member_code: binary(),
            subsystem_code: binary()
          },
          service: %{
            object_type: binary(),
            xroad_instance: binary(),
            member_class: binary(),
            member_code: binary(),
            subsystem_code: binary(),
            service_code: binary()
          }
        }

  @header_schema %{
    id: {:element, "xroad:id", :string},
    protocol_version: {:element, "xroad:protocolVersion", :string},
    user_id: {:element, "xroad:userId", :string},
    client:
      {:element, "xroad:client",
       %{
         object_type: {:attribute, "id:objectType", :string},
         xroad_instance: {:element, "id:xRoadInstance", :string},
         member_class: {:element, "id:memberClass", :string},
         member_code: {:element, "id:memberCode", :string},
         subsystem_code: {:element, "id:subsystemCode", :string}
       }},
    service:
      {:element, "xroad:service",
       %{
         object_type: {:attribute, "id:objectType", :string},
         xroad_instance: {:element, "id:xRoadInstance", :string},
         member_class: {:element, "id:memberClass", :string},
         member_code: {:element, "id:memberCode", :string},
         subsystem_code: {:element, "id:subsystemCode", :string},
         service_code: {:element, "id:serviceCode", :string}
       }}
  }

  @namespaces [
    soap11env: "http://schemas.xmlsoap.org/soap/envelope/",
    xroad: "http://x-road.eu/xsd/xroad.xsd",
    id: "http://x-road.eu/xsd/identifiers"
  ]

  @spec new(
          binary(),
          binary(),
          %{
            member_class: binary(),
            member_code: binary(),
            subsystem_code: binary()
          },
          %{
            member_class: binary(),
            member_code: binary(),
            subsystem_code: binary(),
            service_code: binary()
          },
          term(),
          keyword()
        ) :: t(term())
  def new(user_id, xroad_instance, client, service, content, opts \\ []) do
    %{
      header: %{
        id: Keyword.get(opts, :id, UUID.uuid4()),
        protocol_version: "4.0",
        user_id: user_id,
        client: %{
          object_type: "SUBSYSTEM",
          xroad_instance: xroad_instance,
          member_class: client.member_class,
          member_code: client.member_code,
          subsystem_code: client.subsystem_code
        },
        service: %{
          object_type: "SERVICE",
          xroad_instance: xroad_instance,
          member_class: service.member_class,
          member_code: service.member_code,
          subsystem_code: service.subsystem_code,
          service_code: service.service_code
        }
      },
      body: %{
        content: content
      }
    }
  end

  @spec schema(EHCS.XmlSerializer.Schema.t()) :: EHCS.XmlSerializer.Schema.t()
  def schema(content_schema)

  def schema(content_schema) when is_atom(content_schema) do
    element = content_schema.element()
    element_schema = content_schema.schema()
    namespaces = content_schema.namespaces()
    schema({element, element_schema, namespaces})
  end

  def schema({element, element_schema}) do
    schema({element, element_schema, []})
  end

  def schema({element, element_schema, namespaces}) do
    {"soap11env:Envelope",
     %{
       header: {:element, "soap11env:Header", @header_schema},
       body:
         {:element, "soap11env:Body",
          %{
            content: {:element, element, element_schema}
          }}
     }, @namespaces ++ namespaces}
  end
end
