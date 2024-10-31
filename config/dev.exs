import Config

config :uc6, EHCS.UC6.Repo,
  database: "uc6",
  username: "postgres",
  hostname: "localhost"

config :trembita, :globals,
  endpoint: "https://webhook-test.com/ec9abb167a8e8b6b63d5a50f130ad7f7",
  user_id: "mimir_test",
  xroad_instance: "SEVDEIR-TEST",
  client: [
    member_class: "GOV",
    member_code: "42032422",
    subsystem_code: "50_eHealth_demo_PUSH"
  ]

config :uc6, EHCS.UC6.Trembita,
  endpoint: "https://webhook-test.com/ec9abb167a8e8b6b63d5a50f130ad7f7",
  user: "mimir_test",
  client_xroad_instance: "SEVDEIR-TEST",
  client_member_class: "GOV",
  client_member_code: "42032422",
  client_subsystem_code: "50_eHealth_demo_PUSH",
  service_xroad_instance: "SEVDEIR-TEST",
  service_member_class: "GOV",
  service_member_code: "43395033",
  service_subsystem_code: "DpDiiaTest_33_prod",
  partner_id: "i8NmiBIDNktkNSwMvJsN0QGLJhY1R9HK2JIeRH83ZPp5bBO4O0"

config :uc6, EHCS.UC6.Channel,
  templates: [
    %{
      name: "template_for_create_service_request",
      id:
        "749af9c1df419f50e99f4ea3f74f76dd2e8f6b4e572d08d0628db15085f679285c89239c7a5eee9ded3d9363c71b5e8da009609d594a9aeaeaed75096ccfc1f0"
    }
  ]

config :uc6_api, EHCS.UC6.API.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  debug_errors: false,
  secret_key_base: "r+8WPL2NHsH927X1li8qLtUDSWRKEL3ruZPUY/uRwQwmJBjR+If2UepbqCHQGSBm"
