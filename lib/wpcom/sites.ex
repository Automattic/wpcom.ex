defmodule Wpcom.Sites do
  import Wpcom.Oauth2, only: [auth_header: 0]

  def get(site) do
    Wpcom.Req.get(:wpcomV1dot1, "/sites/#{site}", [], [auth_header()])
  end

  def list_users(site, params \\ []) do
    Wpcom.Req.get(:wpV2, "/sites/#{site}/users", params, [auth_header()])
  end

  def search(site, params) do
    Wpcom.Req.get(:wpcomV1dot2, "/sites/#{site}/search", params, [auth_header()])
  end
end
