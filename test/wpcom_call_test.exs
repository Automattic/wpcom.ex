defmodule WpcomCallTest do
  use ExUnit.Case

  @token Application.get_env(:wpcom, :token)

  test "get /me endpoint" do
    {:ok, %{"ID" => id}} = Wpcom.Call.get("/me", [{"Authorization", @token}])
    assert is_integer(id)
  end
end
