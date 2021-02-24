defmodule Elixpay.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias Elixpay.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:balance, :user_id]

  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User


    timestamps()
  end


  def changeset(params, account \\ %__MODULE__{}) do
    account
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> check_constraint(:balance, name: :balance_not_negative)
  end
end
