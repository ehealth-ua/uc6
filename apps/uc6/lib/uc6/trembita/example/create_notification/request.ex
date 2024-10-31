defmodule EHCS.UC6.Trembita.CreateNotification.Request do
  alias EHCS.XmlSerializer.Schema

  @type t :: %{
          partner_id: binary(),
          template_id: binary(),
          recipients: [
            %{
              id: binary(),
              rnokpp: binary(),
              parameters: [
                %{key: binary(), value: binary()}
              ]
            }
          ]
        }

  @schema %{
    partner_id: {:element, "tns:partnerId", :string},
    template_id: {:element, "tns:templateId", :string},
    recipients:
      {:element, "tns:recipients",
       [
         {:element, "tns1:RecipientsNotification",
          %{
            id: {:element, "tns1:id", :string},
            rnokpp: {:element, "tns1:rnokpp", :string},
            parameters:
              {:element, "tns1:parameters",
               [
                 {:element, "tns1:parameter",
                  %{
                    key: {:element, "tns1:key", :string},
                    value: {:element, "tns1:value", :string}
                  }}
               ]}
          }}
       ]}
  }

  use Schema,
    element: "tns:NotificationCreate",
    schema: @schema,
    namespaces: [
      tns: "NotificationDistributionPush",
      tns1: "notification.notification_distribution_push"
    ]
end
