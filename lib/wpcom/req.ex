defmodule Wpcom.Req do
  @moduledoc """
  Low-level request functionality for WP.com REST API.

  Accepts GET or POST types. Optional headers. JSON body.
  """

  @type http_header :: {String.t(), String.t()}
  @type http_headers :: [http_header]
  @type http_response :: {:ok, String.t() | map} | {:error, Mojito.error()} | no_return

  @doc "Make a request to WP.com REST API."
  @spec request(:get | :post, String.t(), http_headers, String.t() | map) :: http_response
  def request(method, url, custom_headers \\ [], body \\ "")

  def request(method, url, custom_headers, body) when is_map(body) do
    headers = custom_headers ++ [{"Content-Type", "application/json"}]
    request(method, url, headers, Jason.encode!(body))
  end

  def request(method, url, custom_headers, body) do
    headers = custom_headers ++ [{"User-Agent", "wpcom.ex/" <> version()}]

    Mojito.request(method, url, headers, body)
    |> case do
      {:ok, response} -> {:ok, maybe_decode(response.body)}
      error -> error
    end
  end

  defp maybe_decode(string) do
    case Jason.decode(string) do
      {:ok, json} -> json
      _ -> string
    end
  end

  defp version do
    Application.spec(:wpcom, :vsn) |> to_string()
  end
end
