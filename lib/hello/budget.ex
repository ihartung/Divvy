defmodule Hello.Budget do
  use Ecto.Schema
  import Ecto.Changeset


  schema "expenses" do
    field :cost, :decimal
    field :title, :string

    timestamps()
  end



  @doc false
  def changeset(budget, attrs) do
    budget
    |> cast(attrs, [:title, :cost])
    |> validate_required([:title, :cost])
  end
end
