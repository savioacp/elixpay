defmodule Elixpay.Accounts.Transaction do
  alias Elixpay.Repo
  alias Elixpay.Accounts.Operation
  alias Elixpay.Accounts.Transactions.Response, as: TransactionResponse
  alias Ecto.Multi


  def call(%{"from" => from_id, "to" => to_id, "value" => value}) do
    result =
      with {:ok, value}   <- Decimal.cast(value),
           {:ok, changes} <- do_update(from_id, to_id, value) do

        {:ok, changes}
      end

    case result do

      {:ok, %TransactionResponse{} = response}
        -> {:ok, response}

      :error
        -> {:error, "Invalid decimal value."}

      {:error, _, reason, _}
        -> {:error, reason}

    end

  end

  defp do_update(from_id, to_id, value) do
    Multi.new()
    |> Multi.run(:sender, fn _repo, _changes ->
      Operation.do_update(from_id, value, :withdraw) |> handle_update()
    end)
    |> Multi.run(:receiver, fn _repo, _changes ->
      Operation.do_update(to_id, value, :deposit) |> handle_update()
    end)
    |> Repo.transaction()
  end

  defp handle_update({1, [account]}), do: {:ok, account}
  defp handle_update({0, _}), do: {:error, "Account not found"}
end
