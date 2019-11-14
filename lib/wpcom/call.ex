defmodule Wpcom.Call do
  @moduledoc """
  Synchronous HTTP request functions for the WordPress.com REST API
  """

  @doc "Performs a synchronous GET request to the WP.com API"
  @spec get(
          String.t(),
          [{String.t(), String.t()}]
        ) :: {:error, any()} | {:ok, any()}
  def get(path, headers \\ []) do
    Wpcom.Req.request(:get, path, headers)
  end

  @doc "Performs a synchronous POST request to the WP.com API"
  @spec post(
          String.t(),
          %{} | String.t(),
          [{String.t(), String.t()}]
        ) :: {:error, any()} | {:ok, any()}
  def post(path, body, headers \\ []) do
    Wpcom.Req.request(:post, path, headers, body)
  end

  @doc "Aliased to post/3. Performs a synchronous POST request to the WP.com API"
  @spec put(
          String.t(),
          %{} | String.t(),
          [{String.t(), String.t()}]
        ) :: {:error, any()} | {:ok, any()}
  def put(path, body, headers \\ []) do
    post(path, body, headers)
  end

  @doc "Aliased to post/3. Performs a synchronous DELETE request to the WP.com API"
  @spec del(
          String.t(),
          [{String.t(), String.t()}]
        ) :: {:error, any()} | {:ok, any()}
  def del(path, headers) do
    post(path, "", headers)
  end
end
