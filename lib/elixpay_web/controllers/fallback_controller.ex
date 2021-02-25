defmodule ElixpayWeb.FallbackController do
  use ElixpayWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ElixpayWeb.ErrorView)
    |> render("400.json", result: changeset)
  end

  def call(conn, {:error, error}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(ElixpayWeb.ErrorView)
    |> render("generic.json", error: error)
  end
end
