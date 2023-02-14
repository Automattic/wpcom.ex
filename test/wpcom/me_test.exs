defmodule Wpcom.MeTest do
  use ExUnit.Case

  setup do
    TestServer.start()
    Application.put_env(:wpcom, :unit_test, TestServer.url())
  end

  test "me/0" do
    TestServer.add("/me", via: :get)
    assert {:ok, _response} = Wpcom.Me.me()
  end

  test "my_sites/0" do
    TestServer.add("/me/sites", via: :get)
    assert {:ok, _response} = Wpcom.Me.my_sites()
  end
end
