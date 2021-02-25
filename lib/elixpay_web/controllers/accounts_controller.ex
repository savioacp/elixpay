defmodule ElixpayWeb.AccountsController do
  use ElixpayWeb, :controller

  action_fallback ElixpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Elixpay.Account{} = account} <- Elixpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Elixpay.Account{} = account} <- Elixpay.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end
end
