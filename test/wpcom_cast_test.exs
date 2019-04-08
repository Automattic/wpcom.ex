defmodule WpcomCastTest do
  use ExUnit.Case

  @token Application.get_env(:wpcom, :token)

  test "get /me endpoint" do
    assert {:ok, _pid } = Wpcom.Cast.post("/dummy", "", [{"Authorization", @token}])
  end
end
