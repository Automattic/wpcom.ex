defmodule Wpcom.Req do
  @moduledoc """
  Low-level request functionality for WP.com REST API.

  Accepts GET or POST types. Optional headers. JSON body.
  """

  @type api_version :: :restV1 | :restV11 | :wpV2 | :wpcomV2 | :wpcomV3 | :wpcomV4

  @api_versions [:restV1, :restV11, :wpV2, :wpcomV2, :wpcomV3, :wpcomV4]
  @api_base %{
    restV1: "https://public-api.wordpress.com/rest/v1",
    restV11: "https://public-api.wordpress.com/rest/v1.1",
    wpV2: "https://public-api.wordpress.com/wp/v2",
    wpcomV2: "https://public-api.wordpress.com/wpcom/v2",
    wpcomV3: "https://public-api.wordpress.com/wpcom/v3",
    wpcomV4: "https://public-api.wordpress.com/wpcom/v4"
  }

  def get(api_version, path, params \\ []) when api_version in @api_versions do
    Req.new()
    |> Req.Request.put_header("user-agent", "wpcom.ex/" <> version())
    |> Req.get(url: api_url(api_version, path), params: params)
  end

  def post(api_version, path, %{} = body) when api_version in @api_versions do
    Req.new()
    |> Req.Request.put_header("user-agent", "wpcom.ex/" <> version())
    |> Req.post(url: api_url(api_version, path), json: body)
  end

  defp api_url(api_version, path) do
    Application.get_env(:wpcom, :unit_test, @api_base[api_version]) <> path
  end

  defp version do
    Application.spec(:wpcom, :vsn) |> to_string()
  end
end
