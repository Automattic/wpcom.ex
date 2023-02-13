defmodule Wpcom.Me do
  import Wpcom.Oauth2, only: [auth_header: 0]

  def me() do
    Wpcom.Req.get(:wpcomV1dot1, "/me", [], [auth_header()])
  end

  def my_sites() do
    Wpcom.Req.get(:wpcomV1dot2, "/me/sites", [], [auth_header()])
  end
end
