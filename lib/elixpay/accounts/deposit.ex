defmodule Elixpay.Accounts.Deposit do
  alias Elixpay.{Account, Repo}
  import Ecto.Query

  def call(%{"id" => account_id, "value" => value}) do
    result =
      from( a in Account, where: a.id == ^account_id,
        select: a
      )
      |> Repo.update_all(inc: [balance: value])


    case result do
      {1, [%Account{} = account]} -> {:ok, account}
      {0, _} -> {:error, "Account not found."}
    end
  end
end
