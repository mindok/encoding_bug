defmodule EncodingBugWeb.Router do
  use EncodingBugWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {EncodingBugWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EncodingBugWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live "/encoding", EncodeLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", EncodingBugWeb do
  #   pipe_through :api
  # end
end
