defmodule ElixpayWeb.UsersController do
  use ElixpayWeb, :controller
  alias Elixpay.User

  action_fallback ElixpayWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Elixpay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
