defmodule ElixpayWeb.WelcomeController do
  use ElixpayWeb, :controller
  alias Elixpay.Numbers

  def index(conn, %{"filename" => filename}) do
    filename
    |> Numbers.sum_from_file()
    |> handle_file_response(conn)

  end

  defp handle_file_response({:ok, %{result: result}}, conn)  do
    conn
    |> put_status(:ok)
    |> json(%{message: "Welcome to Elixirpay API. Here is your number: #{result}"})
  end

  defp handle_file_response({:error, reason}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(%{message: reason})
  end
end
