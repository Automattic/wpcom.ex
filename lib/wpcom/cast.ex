defmodule Wpcom.Cast do
  @moduledoc """
  Asynchronous HTTP request functions with infinite exponential retry
  to the WordPress.com REST API.
  """
  use Retry
  require Logger

  @doc "Performs asynchronous POST request to the WP.com API"
  @spec post(String.t(), String.t(), [{String.t(), String.t()}]) :: {:ok, pid()}
  def post(path, body, headers \\ []) do
    Task.start(fn ->
      retry_while with: exponential_backoff(2000) |> randomize() do
        Wpcom.Req.request(:post, path, headers, body)
        |> case do
          {:error, resp} ->
            Logger.warn("http req cast failed!", resp: resp)
            {:cont, resp}

          {_, resp} ->
            Logger.info("http req cast succeeded.", resp: resp)
            {:halt, resp}
        end
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
