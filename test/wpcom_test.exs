defmodule WpcomTest do
  use ExUnit.Case

  @baseurl Application.get_env(:wpcom, :restV11)

  test "api_url no slash" do
    assert Wpcom.api_url("whatever") == @baseurl <> "/whatever"
  end

  test "api_url with slash" do
    assert Wpcom.api_url("/whatever") == @baseurl <> "/whatever"
  end

  test "api_url with all the slashes" do
    assert Wpcom.api_url("/whatever/") == @baseurl <> "/whatever"
  end
end
