defmodule Elixpay.Users.CreateTest do
  use Elixpay.DataCase, async: true

  alias Elixpay.Users.Create
  alias Elixpay.User
  alias Elixpay.Repo

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Savio",
        password: "testeteste1234",
        nickname: "savioacp",
        email: "savioacp@gmail.com",
        age: 17
      }

      {:ok, %User{id: user_id}} = Create.call params

      user = Repo.get User, user_id

      assert %{email: "savioacp@gmail.com", id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Savio",
        nickname: "savioacp",
        email: "savioacp@gmail.com",
        age: 16
      }

      {:error, changeset} = Create.call params

      expected = %{
        age: ["must be greater than or equal to 17"],
        password: ["can't be blank"]
      }

      assert expected == errors_on(changeset)
    end
  end
end
