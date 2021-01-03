defmodule TotalRecallWeb.Router do
  use TotalRecallWeb, :router

  import TotalRecallWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TotalRecallWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TotalRecallWeb.Telemetry
    end
  end

  scope "/", TotalRecallWeb do
    pipe_through [:browser]

    scope "/accounts" do
      get "/force_logout", UserSessionController, :force_logout, as: :user_logout
      delete "/logout", UserSessionController, :delete
      get "/confirm", UserConfirmationController, :new
      post "/confirm", UserConfirmationController, :create
      get "/confirm/:token", UserConfirmationController, :confirm
    end

    get "/", HomeController, :index
  end

  scope "/", TotalRecallWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    scope "/accounts" do
      get "/signup", UserRegistrationController, :new
      post "/signup", UserRegistrationController, :create
      get "/login", UserSessionController, :new
      post "/login", UserSessionController, :create
      get "/reset_password", UserResetPasswordController, :new
      post "/reset_password", UserResetPasswordController, :create
      get "/reset_password/:token", UserResetPasswordController, :edit
      put "/reset_password/:token", UserResetPasswordController, :update
    end
  end

  scope "/", TotalRecallWeb do
    pipe_through [:browser, :require_authenticated_user]

    scope "/accounts" do
      get "/accounts/edit", UserSettingsController, :edit
      put "/accounts/edit", UserSettingsController, :update
      get "/accounts/settings/confirm_email/:token", UserSettingsController, :confirm_email
    end

    get "/", UserDashboardController, :show
  end
end
