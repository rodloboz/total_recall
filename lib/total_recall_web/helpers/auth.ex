defmodule TotalRecallWeb.Helpers.Auth do
  @moduledoc """
  Auth defines Authentication helpers.
  """

  def signed_in?(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id, do: !!TotalRecall.Repo.get(TotalRecall.Accounts.User, user_id)
  end
end
