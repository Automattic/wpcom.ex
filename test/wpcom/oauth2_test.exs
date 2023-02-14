defmodule Wpcom.Oauth2Test do
  use ExUnit.Case, async: true

  test "authorize_url/4" do
    assert Wpcom.Oauth2.authorize_url(42, "http://localhost:4000/something") ==
             "https://public-api.wordpress.com/oauth2/authorize?client_id=42&redirect_uri=http%3A%2F%2Flocalhost%3A4000%2Fsomething&response_type=code&scope=auth"
  end

  test "authorize_url/4 with specific blog" do
    assert Wpcom.Oauth2.authorize_url(42, "http://localhost:4000/something", :auth, 740) ==
             "https://public-api.wordpress.com/oauth2/authorize?blog=740&client_id=42&redirect_uri=http%3A%2F%2Flocalhost%3A4000%2Fsomething&response_type=code&scope=auth"
  end

  test "authorize_url/4 with global scope" do
    assert Wpcom.Oauth2.authorize_url(42, "http://localhost:4000/something", :global) ==
             "https://public-api.wordpress.com/oauth2/authorize?client_id=42&redirect_uri=http%3A%2F%2Flocalhost%3A4000%2Fsomething&response_type=code&scope=global"
  end

  test "retrieve_token/5" do
    TestServer.add("/oauth2/token", via: :post)
    Application.put_env(:wpcom, :oauth2_unit_test, TestServer.url() <> "/oauth2/token")
    assert {:ok, _} = Wpcom.Oauth2.retrieve_token(1234, "sekret!", "AKBE353", "http://watever")
  end
end
