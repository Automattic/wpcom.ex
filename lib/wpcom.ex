defmodule Wpcom do
  @moduledoc """
  wpcom.ex is the official Elixir library for the WordPress.com REST API
  """

  @default_api :restV11
  @api_base_override Application.get_env(:wpcom, :api_base_override)
  @api_base %{
    restV1: "https://public-api.wordpress.com/rest/v1",
    restV11: "https://public-api.wordpress.com/rest/v1.1",
    wpV2: "https://public-api.wordpress.com/wp/v2",
    wpcomV2: "https://public-api.wordpress.com/wpcom/v2"
  }

  @doc "Fetches api version config value if it exists and valid; default if not."
  @spec get_api_version() :: :restV1 | :restV11 | :wpV2 | :wpcomV2
  def get_api_version do
    version = Application.get_env(:wpcom, :api_version)

    if @api_base[version] do
      version
    else
      @default_api
    end
  end

  @doc "Switches wpcom.ex to the supplied api version."
  @spec switch_api_version(:restV1 | :restV11 | :wpV2 | :wpcomV2) :: :ok
  def switch_api_version(new_version) do
    Application.put_env(:wpcom, :api_version, new_version)
  end

  @doc "Builds api base URL."
  @spec api_base(:restV1 | :restV11 | :wpV2 | :wpcomV2) :: String.t()
  def api_base(version) do
    @api_base_override || Map.get(@api_base, version, @api_base[@default_api])
  end

  @doc "Builds a full API url using the supplied path and optional api version."
  @spec api_url(String.t(), :restV1 | :restV11 | :wpV2 | :wpcomV2 | nil) :: String.t()
  def api_url(endpoint, api_version \\ nil) do
    version = api_version || get_api_version()

    version
    |> api_base()
    |> Path.join(endpoint)
  end
end
