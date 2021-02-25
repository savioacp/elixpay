defmodule Elixpay.Accounts.Withdraw do
  alias Elixpay.Accounts.Operation

  def call(params) do
    Operation.call(params, :withdraw)
  end
end
