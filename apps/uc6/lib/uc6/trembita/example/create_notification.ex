defmodule EHCS.UC6.Trembita.CreateNotification do
  use EHCS.Trembita.Call,
    request: EHCS.UC6.Trembita.CreateNotification.Request,
    response: EHCS.UC6.Trembita.CreateNotification.Response,
    member_class: opt!(:service_member_class),
    member_code: opt!(:service_member_code),
    subsystem_code: opt!(:service_subsystem_code),
    service_code: "NotificationCreate"

  defp opt!(key) do
    opts = Application.fetch_env!(:uc6, EHCS.UC6.Trembita)
    Keyword.fetch!(opts, key)
  end
end
