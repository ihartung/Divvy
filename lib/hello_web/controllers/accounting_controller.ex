defmodule HelloWeb.AccountingController do
  use HelloWeb, :controller

alias Hello.Balance
alias Hello.Accounting

def start(conn, _params) do
     if Hello.Repo.get(Hello.Balance, 1) do
        Hello.Repo.update_all(Hello.Balance, set: [total: 0.00])
     end
        Hello.Repo.delete_all(Hello.Accounting)
        redirect(conn, to: accounting_path(conn, :index))
end

def index(conn, _params) do
    total = get_balance()
    transactions = Hello.Repo.all(Hello.Accounting)

    render(conn, "index.html", total: total, transactions: transactions)
end

def create(conn, params) do

    changeset = Accounting.changeset(%Accounting{}, params)

    case Hello.Repo.insert(changeset) do
      {:ok, _accounting} ->
	increment = changeset.changes.cost
        Hello.Repo.update_all(Hello.Balance, inc: [total: increment])
        conn
        |> put_flash(:info, "Transaction created successfully.")
        |> redirect(to: accounting_path(conn, :index))
      {:error, changeset} ->
	conn
        |> put_flash(:info, "Please fill in all fields validly.")
        |> redirect(to: accounting_path(conn, :index))
    end
end

def delete(conn, %{"id" => id}) do
	expense = Hello.Repo.get!(Hello.Accounting, id)

	increment = Decimal.div(expense.cost, -1)
	Hello.Repo.update_all(Hello.Balance, inc: [total: increment])
	Hello.Repo.delete!(expense)

	conn
	|> redirect(to: accounting_path(conn, :index))
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
