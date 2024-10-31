defmodule EHCS.UC6.Trembita.DistributionStatus.Request do
  alias EHCS.XmlSerializer.Schema

  @type t :: %{
          partner_id: binary(),
          distribution_id: binary()
        }

  use Schema,
    element: "tns:DistributionStatus",
    schema: %{
      partner_id: {:element, "tns:partnerId", :string},
      distribution_id: {:element, "tns:distributionId", :string}
    },
    namespaces: [
      tns: "NotificationDistributionStatus"
    ]
end
