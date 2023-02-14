defmodule Wpcom do
  @moduledoc """
  wpcom.ex is the official Elixir library for the WordPress.com REST API
  """

  @type result :: {:ok, Req.Response.t()} | {:error, Exception.t()}

  @doc """
  Discover freshly pressed content at WordPress.com
  """
  @spec discover(keyword()) :: result
  def discover(params \\ []) when is_list(params) do
    Wpcom.Req.get(:wpV2, "/sites/discover.wordpress.com/posts", params)
  end

  @doc """
  Make a GET request against any of the API versions that have a test endpoint
  """
  @spec test(:wpcomV1 | :wpcomV1dot1 | :wpcomV1dot2 | :wpcomV1dot3 | :wpcomV2, keyword()) ::
          result
  def test(version \\ :wpcomV1dot1, params \\ [])
  def test(:wpcomV1, params), do: Wpcom.Req.get(:wpcomV1dot1, "/test/24", params)
  def test(:wpcomV1dot1, params), do: Wpcom.Req.get(:wpcomV1dot1, "/test/42", params)
  def test(:wpcomV1dot2, params), do: Wpcom.Req.get(:wpcomV1dot2, "/test/version/84", params)
  def test(:wpcomV1dot3, params), do: Wpcom.Req.get(:wpcomV1dot3, "/test/version/168", params)
  def test(:wpcomV2, _params), do: Wpcom.Req.get(:wpcomV2, "/test")
end
