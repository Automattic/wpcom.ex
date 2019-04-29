defmodule WpcomCastTest do
  use ExUnit.Case

  @token Application.get_env(:wpcom, :auth_token_for_unit_tests)

  test "get /me endpoint" do
    assert {:ok, _pid} = Wpcom.Cast.post("/dummy", "", [{"Authorization", @token}])
  end
end
