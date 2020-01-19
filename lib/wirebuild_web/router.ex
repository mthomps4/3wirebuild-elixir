defmodule WirebuildWeb.Router do
  use WirebuildWeb, :router

  pipeline :auth do
    plug Wirebuild.Account.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

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

  # Maybe logged in routes
  scope "/", WirebuildWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
  end

  scope "/", WirebuildWeb do
    pipe_through [:browser, :auth, :ensure_auth]
    get "/protected", PageController, :protected
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", WirebuildWeb do
  #   pipe_through :api
  # end
end
