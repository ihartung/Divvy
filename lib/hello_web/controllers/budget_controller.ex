defmodule HelloWeb.BudgetController do
  use HelloWeb, :controller

alias Hello.Balance
alias Hello.Budget

def start(conn, _params) do
     if Hello.Repo.get(Hello.Balance, 1) do
	Hello.Repo.update_all(Hello.Balance, set: [total: 0.00])
     end
	Hello.Repo.delete_all(Hello.Budget)
        redirect(conn, to: budget_path(conn, :index))
end

def index(conn, _params) do
    total = get_balance()
    expenses = Hello.Repo.all(Hello.Budget)

    render(conn, "index.html", total: total, expenses: expenses)
end

def create(conn, params) do

    changeset = Budget.changeset(%Budget{}, params)

    case Hello.Repo.insert(changeset) do
      {:ok, _budget} ->
	decrement = Decimal.div(changeset.changes.cost, -1)
	Hello.Repo.update_all(Hello.Balance, inc: [total: decrement])
        conn
        |> put_flash(:info, "Expense created successfully.")
        |> redirect(to: budget_path(conn, :index))
      {:error, changeset} ->
	conn
        |> put_flash(:info, "Please fill in all fields validly.")
        |> redirect(to: budget_path(conn, :index))
    end
end

def delete(conn, %{"id" => id}) do
	expense = Hello.Repo.get!(Hello.Budget, id)

	Hello.Repo.update_all(Hello.Balance, inc: [total: expense.cost])
	Hello.Repo.delete!(expense)

	conn
	|> redirect(to: budget_path(conn, :index))
end

def add_money(conn, params) do

	changeset = Balance.changeset(%Balance{}, params)
	Hello.Repo.update_all(Hello.Balance, inc: [total: changeset.changes.total])

	redirect(conn, to: budget_path(conn, :index))
end

defp get_balance() do

     if Hello.Repo.get(Hello.Balance, 1) do
        #nothing
     else
        Hello.Repo.insert(%Balance{total: 0.00})
     end

     Hello.Repo.get(Hello.Balance, 1)
end

end
