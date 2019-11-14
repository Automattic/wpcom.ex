defmodule Wpcom.Req do
  @moduledoc """
  Low-level request functionality for WP.com REST API.

  Accepts GET or POST types. Optional headers. JSON body.
  """

  import Wpcom, only: [api_url: 1]

  @doc "Make a request to WP.com REST API."
  def request(method, path, custom_headers \\ [], body \\ "")

  @spec request(:get | :post, String.t(), [{String.t(), String.t()}], %{}) ::
          {:error, any()} | {:ok, any()}
  def request(method, path, custom_headers, body) when is_map(body) do
    headers = custom_headers ++ [{"Content-Type", "application/json"}]
    request(method, path, headers, Jason.encode!(body))
  end

  @spec request(:get | :post, String.t(), [{String.t(), String.t()}], String.t()) ::
          {:error, any()} | {:ok, any()}
  def request(method, path, custom_headers, body) do
    headers = custom_headers ++ [{"User-Agent", "wpcom.ex/" <> version()}]

    HTTPoison.request(method, api_url(path), body, headers)
    |> case do
      {:ok, response} -> {:ok, Jason.decode!(response.body)}
      {:error, response} -> {:error, response.reason}
    end
  end

  defp version do
    Application.spec(:wpcom, :vsn) |> to_string()
  end
end
