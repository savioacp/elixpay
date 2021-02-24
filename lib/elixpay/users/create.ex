defmodule Elixpay.Users.Create do
  alias Elixpay.{Repo, User, Account}
  alias Ecto.Multi

  def call(params) do
    result = Multi.new()
      |> Multi.insert(:user, User.changeset(params))
      |> Multi.run(
        :account,
        & &1.insert(
          Account.changeset(%{
            user_id: &2.user.id,
            balance: "0.00"
          })
        ))
      |> Multi.run(:preload, & {:ok, &1.preload(&2.user, :account)})
      |> Repo.transaction()

    case result do
      {:ok, %{preload: %User{} = user}} -> {:ok, user}
      {:error, _,  changeset, _} -> {:error, changeset}
    end
  end
end
