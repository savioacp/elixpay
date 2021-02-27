defmodule ElixpayWeb.AccountsControllerTest do
  use ElixpayWeb.ConnCase, async: true

  alias Elixpay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Savio",
        password: "testeteste1234",
        nickname: "savioacp",
        email: "savioacp@gmail.com",
        age: 17
      }

      {:ok, %User{account: %Account{id: account_id}}} = Elixpay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, deposit correctly", %{conn: conn, account_id: account_id} do
      params = %{
        "value" => "50"
      }

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:ok)

      assert %{
        "account" => %{
          "balance" => "50.00",
          "id" => ^account_id
        },
        "message" => "Balance changed successfully"
      } = response
    end


    test "when not all params are valid, returns an error", %{conn: conn, account_id: account_id} do
      params = %{
        "value" => "invalid"
      }

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(500)

      assert %{"error" => "Invalid value."} = response
    end
  end
end
