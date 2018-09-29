defmodule Hello.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :title, :string
      add :cost, :decimal
      add :category, :string
      add :sign, :string

      timestamps()
    end

  end
end
