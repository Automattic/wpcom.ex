defmodule Wpcom.Req do
  import Wpcom, only: [api_url: 1]

  @spec request(:get | :post, String.t(), [{String.t(), String.t()}], String.t()) ::
          {:error, HTTPoison.Error.t()}
          | {:ok,
             %{
               :__struct__ => HTTPoison.AsyncResponse | HTTPoison.Response,
               optional(:body) => any(),
               optional(:headers) => [any()],
               optional(:id) => reference(),
               optional(:request) => HTTPoison.Request.t(),
               optional(:request_url) => any(),
               optional(:status_code) => integer()
             }}
  def request(method, path, headers \\ [], body \\ "") do
    HTTPoison.request(method, api_url(path), body, headers)
  end
end
