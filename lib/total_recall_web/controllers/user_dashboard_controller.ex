
defmodule TotalRecallWeb.UserDashboardController do
  use TotalRecallWeb, :controller

  import Phoenix.LiveView.Controller

  def show(conn, _params) do
    live_render(conn, TotalRecallWeb.RoutineLive.New)
  end
end
