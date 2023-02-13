defmodule Wpcom.Posts do
  import Wpcom.Oauth2, only: [auth_header: 0]

  def create(site, data) when is_map(data) do
    Wpcom.Req.post(:wpV2, "/sites/#{site}/posts", data, [auth_header()])
  end

  def get(site, post_id, params \\ []) when is_integer(post_id) do
    Wpcom.Req.get(:wpV2, "/sites/#{site}/posts/#{post_id}", params, [auth_header()])
  end

  def edit(site, post_id, data) when is_integer(post_id) and is_map(data) do
    Wpcom.Req.post(:wpV2, "/sites/#{site}/posts/#{post_id}", data, [auth_header()])
  end

  def delete(site, post_id) when is_integer(post_id) do
    Wpcom.Req.delete(:wpV2, "/sites/#{site}/posts/#{post_id}", [auth_header()])
  end

  def list(site, params \\ []) do
    Wpcom.Req.get(:wpV2, "/sites/#{site}/posts", params, [auth_header()])
  end
end
