defmodule Wpcom.Req do
  import Wpcom, only: [api_url: 1]

  @spec request(:get | :post, String.t(), [{String.t(), String.t()}], String.t()) ::
          {:error, HTTPoison.Error.t()} | {:ok, HTTPoison.Response.t()}
  def request(method, path, headers \\ [], body \\ "") do
    HTTPoison.request(method, api_url(path), body, headers)
  end
end
