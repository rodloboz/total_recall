defmodule TotalRecallWeb.UserSessionController do
  use TotalRecallWeb, :controller

  alias TotalRecall.Accounts
  alias TotalRecallWeb.UserAuth

  plug :put_layout, {TotalRecallWeb.LayoutView, :auth}

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  def create(conn, %{"user" => user_params}) do
    %{"login" => login, "password" => password} = user_params

    if user = Accounts.get_user_by_login_and_password(login, password) do
      UserAuth.log_in_user(conn, user, user_params)
    else
      render(conn, "new.html", error_message: "Invalid email/username or password")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end

  def force_logout(conn, _params) do
    conn
    |> put_flash(
     :info,
     "You were logged out. Please login again to continue using the application."
    )
    |> UserAuth.log_out_user()
  end
end
