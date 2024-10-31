defmodule EHCS.UC6.Trembita.NotificationStatus.Response do
  alias EHCS.XmlSerializer.Schema

  @type t :: %{
          recipients:
            [
              %{
                id: binary(),
                devices: [
                  %{
                    status: binary()
                  }
                ]
              }
            ]
            | nil,
          error: binary() | nil
        }

  @schema %{
    recipients:
      {:element, "tns:Recipients",
       [
         {
           :element,
           "ns2:Recipient",
           %{
             id: {:element, "ns2:id", :string},
             devices:
               {:element, "ns2:Devices",
                [
                  {
                    :element,
                    "ns2:Device",
                    %{
                      status: {:element, "ns2:status", :string}
                    }
                  }
                ]}
           }
         }
       ]},
    error: {:element, "tns:error", :string}
  }

  use Schema,
    element: "tns:NotificationPushStatusResponse",
    schema: @schema,
    namespaces: [
      tns: "NotificationDistributionPushStatus",
      ns2: "notification.notification_distribution_push_status"
    ]
end
