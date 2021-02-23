defmodule ElixpayWeb.UsersView do
  use ElixpayWeb, :view
  alias Elixpay.User

  def render("create.json", %{user: %User{id: id, name: name, nickname: nickname, email: email}}) do
    %{
      message: "User created",
      user: %{
        id: id,
        name: name,
        nickname: nickname,
        email: email
      }
    }
  end
end
