defmodule Wpcom do
  @moduledoc """
  wpcom.ex is the official Elixir library for the WordPress.com REST API
  """

  @doc "This function builds a full API url using the supplied path."
  @spec api_url(String.t()) :: String.t()
  def api_url(endpoint) do
    version = Application.get_env(:wpcom, :api_version) || :restV11

    Application.get_env(:wpcom, version)
    |> Path.join(endpoint)
  end
end
