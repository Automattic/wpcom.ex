defmodule Wpcom.SitesTest do
  use ExUnit.Case

  setup do
    TestServer.start()
    Application.put_env(:wpcom, :unit_test, TestServer.url())
  end

  test "get/1" do
    TestServer.add("/sites/somesuch.wordpress.com", via: :get)
    assert {:ok, _response} = Wpcom.Sites.get("somesuch.wordpress.com")
  end

  test "list_users/2" do
    TestServer.add("/sites/somesuch.wordpress.com/users", via: :get)
    assert {:ok, _response} = Wpcom.Sites.list_users("somesuch.wordpress.com")
  end

  test "search/2" do
    TestServer.add("/sites/somesuch.wordpress.com/search", via: :post)
    assert {:ok, _response} = Wpcom.Sites.search("somesuch.wordpress.com", %{query: "ah"})
  end
end
