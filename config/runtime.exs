import Config

if config_env() == :prod do
  config :trembita, :globals,
    endpoint: System.fetch_env!("UC6_ENDPOINT"),
    user_id: System.fetch_env!("UC6_USER"),
    xroad_instance: System.fetch_env!("UC6_CLIENT_XROAD_INSTANCE"),
    client: [
      member_class: System.fetch_env!("UC6_CLIENT_MEMBER_CLASS"),
      member_code: System.fetch_env!("UC6_CLIENT_MEMBER_CODE"),
      subsystem_code: System.fetch_env!("UC6_CLIENT_SUBSYSTEM_CODE")
    ]

  config :uc6, EHCS.UC6.Trembita,
    endpoint: System.fetch_env!("UC6_ENDPOINT"),
    user: System.fetch_env!("UC6_USER"),
    client_xroad_instance: System.fetch_env!("UC6_CLIENT_XROAD_INSTANCE"),
    client_member_class: System.fetch_env!("UC6_CLIENT_MEMBER_CLASS"),
    client_member_code: System.fetch_env!("UC6_CLIENT_MEMBER_CODE"),
    client_subsystem_code: System.fetch_env!("UC6_CLIENT_SUBSYSTEM_CODE"),
    service_xroad_instance: System.fetch_env!("UC6_SERVICE_XROAD_INSTANCE"),
    service_member_class: System.fetch_env!("UC6_SERVICE_MEMBER_CLASS"),
    service_member_code: System.fetch_env!("UC6_SERVICE_MEMBER_CODE"),
    service_subsystem_code: System.fetch_env!("UC6_SERVICE_SUBSYSTEM_CODE"),
    partner_id: System.fetch_env!("UC6_PARTNER_ID")

  config :uc6, EHCS.UC6.Channel,
    templates: [
      %{
        name: "template_for_create_service_request",
        id: System.fetch_env!("TEMPLATE_FOR_CREATE_SERVICE_REQUEST")
      }
    ]

  config :uc6, EHCS.UC6.Repo,
    database: System.fetch_env!("DB_NAME"),
    username: System.fetch_env!("DB_USER"),
    password: System.fetch_env!("DB_PASSWORD"),
    hostname: System.fetch_env!("DB_HOST"),
    port: String.to_integer(System.get_env("DB_PORT", "5432")),
    pool_size: String.to_integer(System.get_env("DB_POOL_SIZE", "10"))

  config :uc6_api, EHCS.UC6.API.Endpoint,
    http: [
      port: System.get_env("PORT", "80"),
      protocol_options: [
        max_header_value_length:
          String.to_integer(System.get_env("MAX_HEADER_VALUE_LENGTH", "4096"))
      ]
    ],
    url: [
      host: System.get_env("HOST", "localhost"),
      port: System.get_env("PORT", "80")
    ],
    secret_key_base: System.fetch_env!("SECRET_KEY_BASE")
end
