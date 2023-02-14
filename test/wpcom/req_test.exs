defmodule Wpcom.ReqTest do
  use ExUnit.Case

  setup do
    TestServer.start()
    Application.put_env(:wpcom, :unit_test, TestServer.url())
  end

  test "get/4" do
    TestServer.add("/whatever", via: :get)
    assert {:ok, _response} = Wpcom.Req.get(:wpcomV2, "/whatever")
  end

  test "post/4" do
    TestServer.add("/whatever-else", via: :post)
    assert {:ok, _response} = Wpcom.Req.post(:wpcomV2, "/whatever-else", %{nah: 4})
  end

  test "delete/3" do
    TestServer.add("/whatever-other", via: :delete)
    assert {:ok, _response} = Wpcom.Req.delete(:wpcomV2, "/whatever-other")
  end

  test "get/4 user agent" do
    TestServer.add("/lalala",
      via: :get,
      to: fn conn ->
        assert Plug.Conn.get_req_header(conn, "user-agent") == [
                 "wpcom.ex/" <> (Application.spec(:wpcom, :vsn) |> to_string())
               ]

        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, ~s<{"result": "we good here"}>)
      end
    )

    assert {:ok, _response} = Wpcom.Req.get(:wpcomV2, "/lalala")
  end

  test "post/4 authed" do
    TestServer.add("/important",
      via: :post,
      to: fn conn ->
        assert Plug.Conn.get_req_header(conn, "authorization") == ["Bearer sekret"]

        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, ~s<{"result": "we good here"}>)
      end
    )

    Application.put_env(:wpcom, :oauth2_token, "sekret")
    assert {:ok, _response} = Wpcom.Req.post(:wpcomV2, "/important", %{ai: "yo"})
  end

  test "delete/4 authed, custom headers" do
    TestServer.add("/ouuuuch",
      via: :delete,
      to: fn conn ->
        assert Plug.Conn.get_req_header(conn, "authorization") == ["Bearer sekret2"]
        assert Plug.Conn.get_req_header(conn, "a") == ["1"]
        assert Plug.Conn.get_req_header(conn, "b") == ["2"]

        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, ~s<{"result": "we good here"}>)
      end
    )

    Application.put_env(:wpcom, :oauth2_token, "sekret2")
    assert {:ok, _response} = Wpcom.Req.delete(:wpcomV2, "/ouuuuch", [{"a", "1"}, {"b", "2"}])
  end
end
