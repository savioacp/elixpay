defmodule Elixpay.Accounts.Withdraw do
  alias Elixpay.{Account, Repo}
  import Ecto.Query

  def call(%{"id" => account_id, "value" => value}) do
    result = with {:ok, value} <- Decimal.cast(value),
         {1, [%Account{} = account]} <-
           Repo.update_all(
             from(a in Account,
               where: a.id == ^account_id,
               select: a
             ),
             inc: [balance: Decimal.negate(value)]
           ) do
      {:ok, account}
    end

    case result do
      {:ok, account} -> {:ok, account}
      :error -> {:error, "Invalid value."}
      {0, _} -> {:error, "Account not found."}
    end
  end
end
