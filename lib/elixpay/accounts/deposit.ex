defmodule Elixpay.Accounts.Deposit do
  alias Elixpay.Accounts.Operation

  def call(params) do
    Operation.call(params, :deposit)
  end
end
