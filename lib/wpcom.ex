defmodule Wpcom do
  @moduledoc """
  wpcom.ex is the official Elixir library for the WordPress.com REST API
  """

  @doc "This function switches the library to the supplied api version."
  @spec switch_api_version(:restV1 | :restV11 | :wpV2 | :wpcomV2) :: :ok
  def switch_api_version(new_version) do
    Application.put_env(:wpcom, :api_version, new_version)
  end

  @doc "This function builds a full API url using the supplied path."
  @spec api_url(String.t()) :: String.t()
  def api_url(endpoint) do
    version = Application.get_env(:wpcom, :api_version)
    base_url = Application.get_env(:wpcom, version) || Application.get_env(:wpcom, :restV11)
    base_url |> Path.join(endpoint)
  end
end
