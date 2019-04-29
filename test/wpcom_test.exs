defmodule WpcomTest do
  use ExUnit.Case

  @baseurlV11 Application.get_env(:wpcom, :restV11)
  @baseurlwpcomV2 Application.get_env(:wpcom, :wpcomV2)

  test "api_url no slash" do
    assert Wpcom.api_url("whatever") == @baseurlV11 <> "/whatever"
  end

  test "api_url with slash" do
    assert Wpcom.api_url("/whatever") == @baseurlV11 <> "/whatever"
  end

  test "api_url with all the slashes" do
    assert Wpcom.api_url("/whatever/") == @baseurlV11 <> "/whatever"
  end

  test "api switch attempt" do
    Wpcom.switch_api_version(:wpcomV2)
    assert Wpcom.api_url("/whatever") == @baseurlwpcomV2 <> "/whatever"
  end

  test "broken api switch attempt" do
    Wpcom.switch_api_version(:badapiV3)
    assert Wpcom.api_url("/whatever") == @baseurlV11 <> "/whatever"
  end
end
