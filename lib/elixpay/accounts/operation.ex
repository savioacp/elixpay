defmodule Elixpay.Accounts.Operation do
  alias Elixpay.{Account, Repo}
  import Ecto.Query


  def call(%{"id" => account_id, "value" => value}, operation) do
    result =
      with {:ok, value}                <- Decimal.cast(value),
           {1, [%Account{} = account]} <- do_update(account_id, value, operation) do

        {:ok, account}
      end

    case result do
      {:ok, account} -> {:ok, account}
      :error -> {:error, "Invalid value."}
      {0, _} -> {:error, "Account not found."}
    end
  end

  def do_update(account_id, value, :deposit) do
    Repo.update_all(
      from(a in Account,
        where: a.id == ^account_id,
        select: a
      ),
      inc: [balance: value]
    )
  end

  def do_update(account_id, value, :withdraw) do
    Repo.update_all(
      from(a in Account,
        where: a.id == ^account_id,
        select: a
      ),
      inc: [balance: Decimal.negate(value)]
    )
  end
end
