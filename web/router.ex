defmodule DecidimGraphqlApi.Router do
  use DecidimGraphqlApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DecidimGraphqlApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  forward "/graphql", Absinthe.Plug, schema: DecidimGraphqlApi.Schema
  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: DecidimGraphqlApi.Schema

  # Other scopes may use custom stacks.
  # scope "/api", DecidimGraphqlApi do
  #   pipe_through :api
  # end
end
