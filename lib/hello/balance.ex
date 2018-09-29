defmodule Hello.Balance do
  use Ecto.Schema
  import Ecto.Changeset


  schema "balance" do
    field :total, :decimal

    timestamps()
  end

  @doc false
  def changeset(balance, attrs) do
    balance
    |> cast(attrs, [:total])
    |> validate_required([:total])
  end
end
