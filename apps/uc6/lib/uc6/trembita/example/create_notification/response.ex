defmodule EHCS.UC6.Trembita.CreateNotification.Response do
  alias EHCS.XmlSerializer.Schema

  @type t :: %{
          distribution_id: binary() | nil,
          error: binary() | nil
        }

  use Schema,
    element: "tns:NotificationCreateResponse",
    schema: %{
      distribution_id: {:element, "tns:distributionId", :string},
      error: {:element, "tns:error", :string}
    },
    namespaces: [
      tns: "NotificationDistributionPush"
    ]
end
