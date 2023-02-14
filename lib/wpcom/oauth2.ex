defmodule Wpcom.Oauth2 do
  @moduledoc """
  Interact with WordPress.com and Jetpack sites using OAuth2

  See: https://developer.wordpress.com/docs/oauth2
  """

  @oauth2_authorize_url "https://public-api.wordpress.com/oauth2/authorize"
  @oauth2_token_url "https://public-api.wordpress.com/oauth2/token"

  @type blog_id :: pos_integer()
  @type grant_type ::
          :authorization_code | :client_credentials | :password | :wpcom_exchange_token
  @type scope :: :auth | :global

  @doc """
  Generate a WP.com OAuth2 authorize URL with the given arguments

  Response type is forced to "code" as implicit OAuth is bad practice,
  particularly serverside like this library.
  """
  @spec authorize_url(pos_integer(), String.t(), scope, blog_id | nil) :: String.t()
  def authorize_url(client_id, redirect_uri, scope \\ :auth, blog \\ nil) do
    query_args =
      %{
        client_id: client_id,
        redirect_uri: redirect_uri,
        response_type: "code",
        scope: scope
      }
      |> maybe_put(:blog, blog)
      |> URI.encode_query()

    @oauth2_authorize_url <> "?#{query_args}"
  end

  @doc """
  Retrieve an WP.com OAuth2 token

  Requires a previously returned auth code.
  """
  @spec retrieve_token(pos_integer(), String.t(), String.t(), String.t(), grant_type) ::
          {:ok, Req.Response.t()} | {:error, Exception.t()}
  def retrieve_token(
        client_id,
        client_secret,
        oauth_code,
        redirect_uri,
        grant_type \\ :authorization_code
      ) do
    Req.post(Application.get_env(:wpcom, :oauth2_unit_test, @oauth2_token_url),
      form: %{
        client_id: client_id,
        client_secret: client_secret,
        redirect_uri: redirect_uri,
        code: oauth_code,
        grant_type: grant_type
      }
    )
  end

  defp maybe_put(map, _key, nil), do: map
  defp maybe_put(map, key, value), do: Map.put(map, key, value)
end
