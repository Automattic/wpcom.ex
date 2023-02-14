defmodule Wpcom.PostsTest do
  use ExUnit.Case

  setup do
    TestServer.start()
    Application.put_env(:wpcom, :unit_test, TestServer.url())
  end

  test "create/2" do
    TestServer.add("/sites/somesuch.wordpress.com/posts", via: :post)
    assert {:ok, _response} = Wpcom.Posts.create("somesuch.wordpress.com", %{one: 1})
  end

  test "get/3" do
    TestServer.add("/sites/somesuch.wordpress.com/posts/242", via: :get)
    assert {:ok, _response} = Wpcom.Posts.get("somesuch.wordpress.com", 242)
  end

  test "edit/3" do
    TestServer.add("/sites/somesuch.wordpress.com/posts/242", via: :post)
    assert {:ok, _response} = Wpcom.Posts.edit("somesuch.wordpress.com", 242, %{ya: 2})
  end

  test "delete/2" do
    TestServer.add("/sites/somesuch.wordpress.com/posts/242", via: :delete)
    assert {:ok, _response} = Wpcom.Posts.delete("somesuch.wordpress.com", 242)
  end

  test "list/2" do
    TestServer.add("/sites/somesuch.wordpress.com/posts", via: :get)
    assert {:ok, _response} = Wpcom.Posts.list("somesuch.wordpress.com")
  end
end
