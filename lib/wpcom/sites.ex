defmodule Wpcom.Sites do
  def get(site) do
    Wpcom.Req.get(:wpcomV1dot1, "/sites/#{site}")
  end

  def list_users(site, params \\ []) do
    Wpcom.Req.get(:wpV2, "/sites/#{site}/users", params)
  end

  def search(site, body) do
    Wpcom.Req.post(:wpcomV1dot2, "/sites/#{site}/search", body)
  end
end
