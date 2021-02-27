defmodule ElixpayWeb.UsersViewTest do
  use ElixpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Elixpay.{User, Account}
  test "renders create.json" do

    params = %{
      name: "Savio",
      password: "testeteste1234",
      nickname: "savioacp",
      email: "savioacp@gmail.com",
      age: 17
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Elixpay.create_user(params)

    response = render(ElixpayWeb.UsersView, "create.json", user: user)



    assert %{
      message: "User created",
      user: %{
        id: ^user_id,
        account: %{id: ^account_id, balance: value}
      }
    } = response

    assert Decimal.compare(value, Decimal.new(0)) == :eq

  end
end
