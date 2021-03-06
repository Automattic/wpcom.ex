defmodule WpcomTest do
  use ExUnit.Case

  @baseurlV11 "https://public-api.wordpress.com/rest/v1.1"
  @baseurlwpcomV2 "https://public-api.wordpress.com/wpcom/v2"

  setup do
    Wpcom.switch_api_version(:restV11)
  end

  test "api_url no slash" do
    assert Wpcom.api_url("whatever") == @baseurlV11 <> "/whatever"
  end

  test "api_url with slash" do
    assert Wpcom.api_url("/whatever") == @baseurlV11 <> "/whatever"
  end

  test "api_url with all the slashes" do
    assert Wpcom.api_url("/whatever/") == @baseurlV11 <> "/whatever"
  end

  test "api get version" do
    assert Wpcom.get_api_version() == :restV11
  end

  test "api get base url" do
    assert Wpcom.api_base(:wpcomV2) == @baseurlwpcomV2
  end

  test "broken api get base url" do
    assert Wpcom.api_base(:crazyapiV9) == @baseurlV11
  end

  test "api switch attempt" do
    Wpcom.switch_api_version(:wpcomV2)
    assert Wpcom.api_url("/whatever") == @baseurlwpcomV2 <> "/whatever"
  end

  test "broken api switch attempt" do
    Wpcom.switch_api_version(:badapiV3)
    assert Wpcom.api_url("/whatever") == @baseurlV11 <> "/whatever"
  end

  test "generate wpcom oauth url" do
    assert Wpcom.oauth_authorize_url(42, "http://localhost:4000/something") ==
             "https://public-api.wordpress.com/oauth2/authorize?client_id=42&redirect_uri=http%3A%2F%2Flocalhost%3A4000%2Fsomething&response_type=code&scope=auth"
  end

  test "generate wpcom oauth url with specific blog" do
    assert Wpcom.oauth_authorize_url(42, "http://localhost:4000/something", :auth, 740) ==
             "https://public-api.wordpress.com/oauth2/authorize?blog=740&client_id=42&redirect_uri=http%3A%2F%2Flocalhost%3A4000%2Fsomething&response_type=code&scope=auth"
  end

  test "generate wpcom oauth url with global scope" do
    assert Wpcom.oauth_authorize_url(42, "http://localhost:4000/something", :global) ==
             "https://public-api.wordpress.com/oauth2/authorize?client_id=42&redirect_uri=http%3A%2F%2Flocalhost%3A4000%2Fsomething&response_type=code&scope=global"
  end
end
