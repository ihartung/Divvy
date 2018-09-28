defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
   # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/budget", BudgetController, :start
    get "/budget/internal", BudgetController, :index
    get "/accounting", AccountingController, :start
    get "/accounting/internal", AccountingController, :index
    post "/budget", BudgetController, :create
    post "/budget/deposit", BudgetController, :add_money
    get "/budget/:id", BudgetController, :delete
    post "/accounting", AccountingController, :create
    get "/accounting/:id", AccountingController, :delete
  end

end
