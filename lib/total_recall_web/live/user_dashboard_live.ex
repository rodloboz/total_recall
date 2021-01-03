defmodule TotalRecallWeb.UserDashboardLive do
  @moduledoc """
  A LiveView for the user dashboard.
  """

  use TotalRecallWeb, :live_view

  @impl true
  def render(assigns) do
    TotalRecallWeb.UserDashboardView.render("show.html", assigns)
  end

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)

    {:ok, socket}
  end
end
