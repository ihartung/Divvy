defmodule Hello.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :title, :string
      add :cost, :decimal

      timestamps()
    end

  end
end
