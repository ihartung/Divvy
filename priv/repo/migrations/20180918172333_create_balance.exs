defmodule Hello.Repo.Migrations.CreateBalance do
  use Ecto.Migration

  def change do
    create table(:balance) do
      add :total, :decimal

      timestamps()
    end

  end
end
