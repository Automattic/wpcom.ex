defmodule WpcomTest do
  use ExUnit.Case, async: true

  setup do
    TestServer.start()
    Application.put_env(:wpcom, :unit_test, TestServer.url())
  end

  test "discover/1" do
    path = "/sites/discover.wordpress.com/posts"
    fixture = "test/fixtures/wpv2-sites-discover-wordpress-com-posts-200.json"

    TestServer.add(path, via: :get, to: &set_response(&1, 200, File.read!(fixture)))

    {:ok, response} = Wpcom.discover()

    assert response.status == 200
    assert is_list(response.body)
    assert Enum.count(response.body) == 10
  end

  test "test/1" do
    fixture = "test/fixtures/rest1dot1-test-200.json"
    TestServer.add("/test/42", via: :get, to: &set_response(&1, 200, File.read!(fixture)))

    {:ok, response} = Wpcom.test()

    assert response.status == 200
    assert response.body["default_int"] == 100
    assert response.body["datetime"] == "2023-02-12T15:18:29+00:00"
  end

  defp set_response(conn, http_code, body) do
    conn
    |> Plug.Conn.put_resp_header("content-type", "application/json")
    |> Plug.Conn.resp(http_code, body)
  end
end
