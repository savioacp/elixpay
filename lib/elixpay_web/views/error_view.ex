defmodule ElixpayWeb.ErrorView do
  use ElixpayWeb, :view

  import ElixpayWeb.ErrorHelpers, only: [errors_from_changeset: 1]


  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def render("400.json", %{result: %Ecto.Changeset{} = changeset}) do
    errors = errors_from_changeset(changeset)

    # errors =
    #   changeset.errors
    #   |> Enum.map(fn
    #     {field, {message, _}} ->
    #       "#{field} #{message}"
    #   end)

    IO.inspect(errors)

    %{
      errors: errors
    }
  end
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
