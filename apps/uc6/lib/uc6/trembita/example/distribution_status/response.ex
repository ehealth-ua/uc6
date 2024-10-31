defmodule EHCS.UC6.Trembita.DistributionStatus.Response do
  alias EHCS.XmlSerializer.Schema

  @type t :: %{
          status: binary()
        }

  use Schema,
    element: "tns:DistributionStatusResponse",
    schema: %{
      status: {:element, "tns:status", :string}
    },
    namespaces: [
      tns: "NotificationDistributionStatus"
    ]
end
