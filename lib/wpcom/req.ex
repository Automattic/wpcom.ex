defmodule Wpcom.Req do
  @moduledoc """
  Low-level request functionality for WP.com REST API.

  Accepts GET or POST types. Optional headers. JSON body.
  """

  @type api_version ::
          :wpcomV1
          | :wpcomV1dot1
          | :wpcomV1dot2
          | :wpcomV1dot3
          | :wpcomV1dot4
          | :wpV2
          | :wpcomV2
          | :wpcomV3
          | :wpcomV4

  @api_versions [
    :wpcomV1,
    :wpcomV1dot1,
    :wpcomV1dot2,
    :wpcomV1dot3,
    :wpcomV1dot4,
    :wpV2,
    :wpcomV2,
    :wpcomV3,
    :wpcomV4
  ]

  @api_base %{
    wpcomV1: "https://public-api.wordpress.com/rest/v1",
    wpcomV1dot1: "https://public-api.wordpress.com/rest/v1.1",
    wpcomV1dot2: "https://public-api.wordpress.com/rest/v1.2",
    wpcomV1dot3: "https://public-api.wordpress.com/rest/v1.3",
    wpcomV1dot4: "https://public-api.wordpress.com/rest/v1.4",
    wpV2: "https://public-api.wordpress.com/wp/v2",
    wpcomV2: "https://public-api.wordpress.com/wpcom/v2",
    wpcomV3: "https://public-api.wordpress.com/wpcom/v3",
    wpcomV4: "https://public-api.wordpress.com/wpcom/v4"
  }

  def get(api_version, path, params \\ [], headers \\ [])
      when api_version in @api_versions and is_list(params) and is_list(headers) do
    Req.new()
    |> Req.Request.put_header("user-agent", "wpcom.ex/" <> version())
    |> put_custom_headers(headers)
    |> Req.get(url: api_url(api_version, path), params: params)
  end

  def post(api_version, path, body, headers \\ [])
      when api_version in @api_versions and is_map(body) and is_list(headers) do
    Req.new()
    |> Req.Request.put_header("user-agent", "wpcom.ex/" <> version())
    |> put_custom_headers(headers)
    |> Req.post(url: api_url(api_version, path), json: body)
  end

  def delete(api_version, path, headers \\ [])
      when api_version in @api_versions and is_list(headers) do
    Req.new()
    |> Req.Request.put_header("user-agent", "wpcom.ex/" <> version())
    |> put_custom_headers(headers)
    |> Req.delete(url: api_url(api_version, path))
  end

  defp api_url(api_version, path) do
    Application.get_env(:wpcom, :unit_test, @api_base[api_version]) <> path
  end

  defp put_custom_headers(req, headers) do
    Enum.reduce(headers, req, fn {header, value}, new_req ->
      Req.Request.put_header(new_req, header, value)
    end)
  end

  defp version do
    Application.spec(:wpcom, :vsn) |> to_string()
  end
end
