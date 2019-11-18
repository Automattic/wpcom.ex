defmodule Wpcom.Req do
  @moduledoc """
  Low-level request functionality for WP.com REST API.

  Accepts GET or POST types. Optional headers. JSON body.
  """

  import Wpcom, only: [api_url: 1]

  @type http_header :: {String.t(), String.t()}
  @type http_headers :: [http_header]
  @type http_response :: {:ok, Mojito.response()} | {:error, Mojito.error()} | no_return

  @spec request(:get | :post, String.t(), http_headers, String.t() | map) :: http_response
  def request(method, path, custom_headers \\ [], body \\ "")

  def request(method, path, custom_headers, body) when is_map(body) do
    headers = custom_headers ++ [{"Content-Type", "application/json"}]
    request(method, path, headers, Jason.encode!(body))
  end

  def request(method, path, custom_headers, body) do
    headers = custom_headers ++ [{"User-Agent", "wpcom.ex/" <> version()}]

    Mojito.request(method, api_url(path), headers, body)
    |> case do
      {:ok, response} -> {:ok, Jason.decode!(response.body)}
      {:error, response} -> {:error, response.reason}
    end
  end

  defp version do
    Application.spec(:wpcom, :vsn) |> to_string()
  end
end
