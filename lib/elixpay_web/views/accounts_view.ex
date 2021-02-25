defmodule ElixpayWeb.AccountsView do
  use ElixpayWeb, :view
  alias Elixpay.Account
  alias Elixpay.Accounts.Transactions.Response, as: TransactionResponse

  def render("update.json", %{account: %Account{id: account_id, balance: balance}}) do
    %{
      message: "Balance changed successfully",
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end


  def render("transaction.json", %{transaction: %TransactionResponse{sender: sender, receiver: receiver}}) do
    %{
      message: "Transaction executed successfully",
      sender: %{
        id: sender.id,
        balance: sender.balance
      },
      receiver: %{
        id: receiver.id,
        balance: receiver.balance
      }
    }
  end
end
