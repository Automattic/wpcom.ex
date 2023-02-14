defmodule Wpcom.Posts do
  def create(site, data) when is_map(data) do
    Wpcom.Req.post(:wpV2, "/sites/#{site}/posts", data)
  end

  def get(site, post_id, params \\ []) when is_integer(post_id) do
    Wpcom.Req.get(:wpV2, "/sites/#{site}/posts/#{post_id}", params)
  end

  def edit(site, post_id, data) when is_integer(post_id) and is_map(data) do
    Wpcom.Req.post(:wpV2, "/sites/#{site}/posts/#{post_id}", data)
  end

  def delete(site, post_id) when is_integer(post_id) do
    Wpcom.Req.delete(:wpV2, "/sites/#{site}/posts/#{post_id}")
  end

  def list(site, params \\ []) do
    Wpcom.Req.get(:wpV2, "/sites/#{site}/posts", params)
  end
end
