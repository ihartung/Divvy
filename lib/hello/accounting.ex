defmodule Hello.Accounting do
  use Ecto.Schema
  import Ecto.Changeset


  schema "transactions" do
    field :category, :string
    field :cost, :decimal
    field :sign, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(accounting, attrs) do
    accounting = cast(accounting, attrs, [:title, :cost, :category, :sign])
    tmp = validate_required(accounting, [:title, :cost, :category, :sign])
    if tmp.valid? do
	sign_check(accounting)
    else
	tmp	
    end
  end

  defp sign_check(changeset) do
	sign = get_change(changeset, :sign)
	if String.match?(sign, ~r/debit/) do
		tmp  = Decimal.div(get_change(changeset, :cost), -1)
		changeset
		|> change(cost: tmp)
	else
		changeset
     	end
  end

end
