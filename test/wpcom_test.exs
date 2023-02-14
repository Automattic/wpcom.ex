defmodule WpcomTest do
  use ExUnit.Case

  setup do
    TestServer.start()
    Application.put_env(:wpcom, :unit_test, TestServer.url())
  end

  test "discover/1" do
    TestServer.add("/sites/discover.wordpress.com/posts", via: :get)
    assert {:ok, _response} = Wpcom.discover()
  end

  test "test/1" do
    TestServer.add("/test/42", via: :get)
    assert {:ok, _response} = Wpcom.test()
  end
end
