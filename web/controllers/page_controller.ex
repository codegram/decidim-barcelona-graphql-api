defmodule DecidimGraphqlApi.PageController do
  use DecidimGraphqlApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
