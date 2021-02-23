defmodule ElixpayWeb.UsersController do
  use ElixpayWeb, :controller
  alias Elixpay.User

  def create(conn, params) do
    params
    |> Elixpay.create_user()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %User{} = user}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", user: user)
  end

  defp handle_response({:error, %Ecto.Changeset{errors: errors}}, conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(ElixpayWeb.ErrorView)
    |> render("400.json", result: errors)
  end
end
