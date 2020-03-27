defmodule Wpcom.Cast do
  @moduledoc """
  Asynchronous HTTP request functions with infinite exponential retry
  to the WordPress.com REST API.

  This cast functionality makes zero guarentees about order of delivery.
  It is highly suggested that all operations be idempotent.

  We rely on WP.com API's incredible uptime and expected recovery times
  in failure cases in our assumptions below.
  """

  use Retry
  require Logger

  import Wpcom, only: [api_url: 2]

  @minute_in_ms 60_000
  @max_backoff 60 * @minute_in_ms

  @type api_version :: Wpcom.api_version()
  @type http_headers :: Wpcom.Req.http_headers()
  @type http_response :: Wpcom.Req.http_response()

  @doc """
  Performs asynchronous POST request to the WP.com API.

  The request is fired off in an unsupervised task that does
  an exponential backoff up to the the backoff cap and then
  continues retrying (indefinitely) at that pace.
  """
  @spec post(String.t(), %{} | String.t(), http_headers(), api_version()) :: {:ok, pid()}
  def post(path, body, headers \\ [], api_version \\ nil) do
    Task.start(fn ->
      retry_while with: exponential_backoff(2000) |> cap(@max_backoff) |> randomize() do
        Wpcom.Req.request(:post, api_url(path, api_version), headers, body)
        |> case do
          {:error, resp} ->
            Logger.warn("#{inspect(self())} http req cast failed!", resp: resp)
            {:cont, resp}

          {_, resp} ->
            Logger.debug("#{inspect(self())} http req cast succeeded.", resp: resp)
            {:halt, resp}
        end
      end
    end)
  end

  @doc "Aliased to post/3. Performs asynchronous POST request to the WP.com API"
  @spec put(String.t(), %{} | String.t(), http_headers(), api_version()) :: {:ok, pid()}
  def put(path, body, headers \\ [], api_version \\ nil) do
    post(path, body, headers, api_version)
  end

  @doc "Aliased to post/3. Performs asynchronous DELETE request to the WP.com API"
  @spec del(String.t(), http_headers(), api_version()) :: {:ok, pid()}
  def del(path, headers, api_version \\ nil) do
    post(path, "", headers, api_version)
  end
end
