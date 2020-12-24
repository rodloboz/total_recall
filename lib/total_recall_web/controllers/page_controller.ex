defmodule TotalRecallWeb.PageController do
  use TotalRecallWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
