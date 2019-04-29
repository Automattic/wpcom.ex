defmodule WpcomCallTest do
  use ExUnit.Case

  @token Application.get_env(:wpcom, :token)

  test "get /me endpoint" do
    {:ok, resp} = Wpcom.Call.get("/me", [{"Authorization", @token}])
    assert resp.status_code == 200
  end
end
