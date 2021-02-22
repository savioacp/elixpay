defmodule ElixpayWeb.WelcomeController do
  use ElixpayWeb, :controller

  def index(conn, _params) do
    text(conn, "Welcome!")
  end
end
