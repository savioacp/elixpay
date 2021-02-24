defmodule Elixpay do
  defdelegate create_user(params), to: Elixpay.Users.Create, as: :call

  defdelegate deposit(params), to: Elixpay.Accounts.Deposit, as: :call
  defdelegate withdraw(params), to: Elixpay.Accounts.Withdraw, as: :call
end
