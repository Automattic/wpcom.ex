defmodule Wpcom do
  @moduledoc """
  wpcom.ex is the official Elixir library for the WordPress.com REST API
  """

  @default_api :restV11
  @api_base %{
    restV1: "https://public-api.wordpress.com/rest/v1",
    restV11: "https://public-api.wordpress.com/rest/v1.1",
    wpV2: "https://public-api.wordpress.com/wp/v2",
    wpcomV2: "https://public-api.wordpress.com/wpcom/v2"
  }
  @api_base_override Application.get_env(:wpcom, :api_base_override)
  @oauth_authorize_url "https://public-api.wordpress.com/oauth2/authorize"
  @oauth_token_url "https://public-api.wordpress.com/oauth2/token"

  @type blog_id :: pos_integer() | nil
  @type grant_type ::
          :authorization_code | :client_credentials | :password | :wpcom_exchange_token
  @type scope :: :auth | :global

  @doc """
  Fetches api version config value if it exists and valid; default if not.
  """
  @spec get_api_version() :: :restV1 | :restV11 | :wpV2 | :wpcomV2
  def get_api_version do
    version = Application.get_env(:wpcom, :api_version)

    if @api_base[version] do
      version
    else
      @default_api
    end
  end

  @doc """
  Switches wpcom.ex to the supplied api version.
  """
  @spec switch_api_version(:restV1 | :restV11 | :wpV2 | :wpcomV2) :: :ok
  def switch_api_version(new_version) do
    Application.put_env(:wpcom, :api_version, new_version)
  end

  @doc """
  Builds api base URL.
  """
  @spec api_base(:restV1 | :restV11 | :wpV2 | :wpcomV2) :: String.t()
  def api_base(version) do
    @api_base_override || Map.get(@api_base, version, @api_base[@default_api])
  end

  @doc """
  Builds a full API url using the supplied path and optional api version.
  """
  @spec api_url(String.t(), :restV1 | :restV11 | :wpV2 | :wpcomV2 | nil) :: String.t()
  def api_url(endpoint, api_version \\ nil) do
    version = api_version || get_api_version()

    version
    |> api_base()
    |> Path.join(endpoint)
  end

  @doc """
  Generate a WP.com OAuth authorize URL with the given arguments

  Response type is forced to "code" as implicit OAuth is bad practice,
  particularly serverside like this library.
  """
  @spec oauth_authorize_url(pos_integer(), String.t(), scope, blog_id) :: String.t()
  def oauth_authorize_url(client_id, redirect_uri, scope \\ :auth, blog \\ nil) do
    query_args =
      %{
        client_id: client_id,
        redirect_uri: redirect_uri,
        response_type: "code",
        scope: scope
      }
      |> maybe_put(:blog, blog)
      |> URI.encode_query()

    @oauth_authorize_url <> "?#{query_args}"
  end

  @doc """
  Retrieve an WP.com OAuth token

  Requires a previously returned auth code.
  """
  @spec retrieve_oauth_token(String.t(), pos_integer(), String.t(), String.t(), grant_type) ::
          Wpcom.Req.http_response()
  def retrieve_oauth_token(
        oauth_code,
        client_id,
        client_secret,
        redirect_uri,
        grant_type \\ :authorization_code
      ) do
    headers = [{"content-type", "application/x-www-form-urlencoded"}]

    body =
      URI.encode_query(%{
        client_id: client_id,
        client_secret: client_secret,
        redirect_uri: redirect_uri,
        code: oauth_code,
        grant_type: grant_type
      })

    Wpcom.Call.post(@oauth_token_url, body, headers)
  end

  defp maybe_put(map, _key, nil), do: map
  defp maybe_put(map, key, value), do: Map.put(map, key, value)
end
