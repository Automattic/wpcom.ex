defmodule Wpcom.Call do
  @moduledoc """
  Synchronous HTTP request functions for the WordPress.com REST API
  """

  import Wpcom, only: [api_url: 1]

  @doc "Performs a synchronous GET request to the WP.com API"
  @spec get(String.t(), Wpcom.Req.http_headers()) :: Wpcom.Req.http_response()
  def get(path, headers \\ []) do
    Wpcom.Req.request(:get, api_url(path), headers)
  end

  @doc "Performs a synchronous POST request to the WP.com API"
  @spec post(String.t(), String.t() | map, Wpcom.Req.http_headers()) :: Wpcom.Req.http_response()
  def post(path, body, headers \\ []) do
    Wpcom.Req.request(:post, api_url(path), headers, body)
  end

  @doc "Aliased to post/3. Performs a synchronous POST request to the WP.com API"
  @spec put(String.t(), String.t() | map, Wpcom.Req.http_headers()) :: Wpcom.Req.http_response()
  def put(path, body, headers \\ []) do
    post(path, body, headers)
  end

  @doc "Aliased to post/3. Performs a synchronous DELETE request to the WP.com API"
  @spec del(String.t(), Wpcom.Req.http_headers()) :: Wpcom.Req.http_response()
  def del(path, headers) do
    post(path, "", headers)
  end
end
