defmodule EHCS.UC6.API.Router do
  use EHCS.UC6.API, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EHCS.UC6.API do
    pipe_through :api
    post "/prescriptoins", PrescriptionController, :create
    get "/prescriptoins/:id", PrescriptionController, :get
    get "/prescriptoins", PrescriptionController, :index
    post "/debug", PrescriptionController, :debug
  end
end
