defmodule Elixpay.Accounts.Deposit do
  alias Ecto.Multi
  alias Elixpay.{Account, Repo}

  def call(%{"id" => account_id, "value" => value}) do
    result = Multi.new()
    |> Multi.run(:account, fn repo, _ -> get_account(repo, account_id) end)
    |> Multi.run(:update_balance, &update_balance(&1, &2.account, value))
    |> Repo.transaction()


    case result do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{update_balance: account}} -> {:ok, account}
    end
  end

  def get_account(repo, id) do
    case repo.get(Account, id) do
      %Account{} = account -> {:ok, account}
      _ -> {:error, "Account does not exist."}
    end
  end

  defp update_balance(repo, account, value) do
    account
    |> sum_values(value)
    |> update_account(repo, account)
  end

  defp sum_values(%Account{balance: balance}, value) do
    value
    |> Decimal.cast()
    |> handle_cast(balance)
  end

  defp handle_cast({:ok, value}, balance), do: Decimal.add(value, balance)
  defp handle_cast(:error, _balance), do: {:error, "Invalid deposit value"}

  defp update_account({:error, _reason} = error, _repo, _account), do: error

  defp update_account(value, repo, account) do
    %{balance: value}
    |> Account.changeset(account)
    |> repo.update()
  end
end
