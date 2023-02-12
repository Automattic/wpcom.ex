defmodule Wpcom do
  @moduledoc """
  wpcom.ex is the official Elixir library for the WordPress.com REST API
  """

  def discover(params \\ []) do
    Wpcom.Req.get(:wpV2, "/sites/discover.wordpress.com/posts", params)
  end
end
