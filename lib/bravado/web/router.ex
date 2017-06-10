defmodule Bravado.Web.Router do
  use Bravado.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Bravado.Defender
  end

  scope "/", Bravado.Web do
    pipe_through :api

    get "/", PageController, :index
  end
end
