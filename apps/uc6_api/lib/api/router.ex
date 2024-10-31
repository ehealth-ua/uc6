defmodule EHCS.UC6.API.Router do
  use EHCS.UC6.API, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EHCS.UC6.API do
    pipe_through :api
    post "/prescriptoins", PushMessageController, :create
    get "/prescriptoins/:id", PushMessageController, :get
    get "/prescriptoins", PushMessageController, :index
    post "/debug", PushMessageController, :debug
  end
end
