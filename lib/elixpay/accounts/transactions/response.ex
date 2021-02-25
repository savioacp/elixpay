defmodule Elixpay.Accounts.Transactions.Response do
  alias Elixpay.Account
  defstruct [:sender, :receiver]

  def new(%Account{} = sender, %Account{} = receiver) do
    %__MODULE__{
      sender: sender,
      receiver: receiver
    }
  end
end
