defmodule Wpcom.Cast do
  @moduledoc """
  Asynchronous HTTP request functions--we don't care if they succeeded or
  failed--for the WordPress.com REST API
  """

  require Logger

  @doc "Performs asynchronous POST request to the WP.com API"
  @spec post(String.t(), String.t(), [{String.t(), String.t()}]) :: {:ok, pid()}
  def post(path, body, headers \\ []) do
    Task.start(fn ->
      {result, resp} = Wpcom.Req.request(:post, path, headers, body)

      if :error == result do
        Logger.warn("http req cast failed!", resp)
      end
    end)
  end

  @doc "Aliased to post/3. Performs asynchronous POST request to the WP.com API"
  @spec put(String.t(), String.t(), [{String.t(), String.t()}]) :: {:ok, pid()}
  def put(path, body, headers \\ []) do
    post(path, body, headers)
  end

  @doc "Aliased to post/3. Performs asynchronous DELETE request to the WP.com API"
  @spec del(String.t(), [{String.t(), String.t()}]) :: {:ok, pid()}
  def del(path, headers) do
    post(path, "", headers)
  end
end
