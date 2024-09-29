defmodule Wpcom.Oauth2Test do
  use ExUnit.Case, async: true

  test "authorize_url/4" do
    url = Wpcom.Oauth2.authorize_url(42, "http://localhost:4000/something")

    assert_valid_authorize_url(url, %{
      scope: "auth",
      client_id: "42",
      redirect_uri: "http://localhost:4000/something",
      response_type: "code"
    })
  end

  test "authorize_url/4 with specific blog" do
    url = Wpcom.Oauth2.authorize_url(42, "http://localhost:4000/something", :auth, 740)

    assert_valid_authorize_url(url, %{
      scope: "auth",
      client_id: "42",
      redirect_uri: "http://localhost:4000/something",
      response_type: "code",
      blog: "740"
    })
  end

  test "authorize_url/4 with global scope" do
    url = Wpcom.Oauth2.authorize_url(42, "http://localhost:4000/something", :global)

    assert_valid_authorize_url(url, %{
      scope: "global",
      client_id: "42",
      redirect_uri: "http://localhost:4000/something",
      response_type: "code"
    })
  end

  test "retrieve_token/5" do
    TestServer.add("/oauth2/token", via: :post)
    Application.put_env(:wpcom, :oauth2_unit_test, TestServer.url() <> "/oauth2/token")
    assert {:ok, _} = Wpcom.Oauth2.retrieve_token(1234, "sekret!", "AKBE353", "http://watever")
  end

  # Helper function to assert the validity of the authorize URL
  defp assert_valid_authorize_url(url, expected_params) do
    uri = URI.parse(url)
    assert uri.scheme == "https"
    assert uri.host == "public-api.wordpress.com"
    assert uri.path == "/oauth2/authorize"

    query_params = URI.decode_query(uri.query)

    Enum.each(expected_params, fn {key, value} ->
      assert Map.get(query_params, to_string(key)) == value
    end)

    assert map_size(query_params) == map_size(expected_params)
  end
end
