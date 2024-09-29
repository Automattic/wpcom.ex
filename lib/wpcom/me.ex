defmodule Wpcom.Me do
  @moduledoc """
  Provides functions to interact with the WordPress.com API endpoints related to the current user.

  This module offers methods to retrieve information about the authenticated user and their sites.
  """

  def me() do
    Wpcom.Req.get(:wpcomV1dot1, "/me")
  end

  def my_sites() do
    Wpcom.Req.get(:wpcomV1dot2, "/me/sites")
  end
end
