defmodule ElixpayWeb.AccountsController do
  use ElixpayWeb, :controller

  def deposit(conn, params) do
    with {:ok, %Elixpay.Account{}} <- Elixpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> json(%{
        message: "It was a success, but the message isn't ready :-/"
      })
      # |> render("show.json", account)
    end
  end

  def withdraw(conn, _params) do
    conn
    |> put_status(:not_implemented)
    |> text("Not Implemented")
  end
end
