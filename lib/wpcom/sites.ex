defmodule Wpcom.Sites do
  @moduledoc """
  Provides functions to interact with the WordPress.com API endpoints related to sites.

  This module offers methods to retrieve site information, list users of a site,
  and perform searches within a site. It uses different versions of the WordPress.com API
  depending on the specific operation.
  """

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
