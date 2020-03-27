defmodule Wpcom.Call do
  @moduledoc """
  Synchronous HTTP request functions for the WordPress.com REST API
  """

  import Wpcom, only: [api_url: 2]

  @type api_version :: Wpcom.api_version()
  @type http_headers :: Wpcom.Req.http_headers()
  @type http_response :: Wpcom.Req.http_response()

  @doc "Performs a synchronous GET request to the WP.com API"
  @spec get(String.t(), http_headers(), api_version()) :: http_response()
  def get(path, headers \\ [], api_version \\ nil) do
    Wpcom.Req.request(:get, api_url(path, api_version), headers)
  end

  @doc "Performs a synchronous POST request to the WP.com API"
  @spec post(String.t(), String.t() | map, http_headers(), api_version()) :: http_response()
  def post(path, body, headers \\ [], api_version \\ nil) do
    Wpcom.Req.request(:post, api_url(path, api_version), headers, body)
  end

  @doc "Aliased to post/3. Performs a synchronous POST request to the WP.com API"
  @spec put(String.t(), String.t() | map, http_headers(), api_version()) :: http_response()
  def put(path, body, headers \\ [], api_version \\ nil) do
    post(path, body, headers, api_version)
  end

  @doc "Aliased to post/3. Performs a synchronous DELETE request to the WP.com API"
  @spec del(String.t(), http_headers(), api_version()) :: http_response()
  def del(path, headers, api_version \\ nil) do
    post(path, "", headers, api_version)
  end
end
