defmodule Elixpay do
  defdelegate create_user(params), to: Elixpay.Users.Create, as: :call
end
