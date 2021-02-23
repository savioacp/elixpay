defmodule Rocketpay.NumbersTest do
  use ExUnit.Case

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "when there is a file with the given name, the sum of the numbers will be returned" do
      response = Numbers.sum_from_file "numbers"

      assert response == {:ok, %{result: 37}}
    end

    test "when there is no file with the given name, an error will be returned" do
      response = Numbers.sum_from_file "this_file_does_not_exist"

      assert response == {:error, "There was an error reading the file."}
    end
  end
end
