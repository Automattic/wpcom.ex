defmodule WpcomCallTest do
  use ExUnit.Case

  @token Application.get_env(:wpcom, :auth_token_for_unit_tests)

  setup do
    Wpcom.switch_api_version(:restV11)
  end

  test "get /me endpoint" do
    {:ok, %{"ID" => id}} = Wpcom.Call.get("/me", [{"Authorization", @token}])
    assert is_integer(id)
  end
end
