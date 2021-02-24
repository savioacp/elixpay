defmodule ElixpayWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  import Ecto.Changeset, only: [traverse_errors: 2]


  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate "is invalid" in the "errors" domain
    #     dgettext("errors", "is invalid")
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # Because the error messages we show in our forms and APIs
    # are defined inside Ecto, we need to translate them dynamically.
    # This requires us to call the Gettext module passing our gettext
    # backend as first argument.
    #
    # Note we use the "errors" domain, which means translations
    # should be written to the errors.po file. The :count option is
    # set by Ecto and indicates we should also apply plural rules.
    if count = opts[:count] do
      Gettext.dngettext(ElixpayWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(ElixpayWeb.Gettext, "errors", msg, opts)
    end
  end

  def errors_from_changeset(%Ecto.Changeset{} = changeset) do
    changeset
    |> traverse_errors(fn {msg, options} ->
      Enum.reduce(options, msg, fn {key, value}, acc ->
        acc |> String.replace("%{#{key}}", to_string(value))
      end)
    end)
    |> Enum.map(fn {key, values} ->
      values |> Enum.map(&"#{key} #{&1}")
    end)
    |> List.flatten()
  end
end
