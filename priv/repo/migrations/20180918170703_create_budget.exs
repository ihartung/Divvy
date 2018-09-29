defmodule Hello.Repo.Migrations.CreateBudget do
  use Ecto.Migration

  def change do
    create table(:budget) do
      add :total, :decimal

      timestamps()
    end

  end
end
