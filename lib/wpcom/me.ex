defmodule Wpcom.Me do
  def me() do
    Wpcom.Req.get(:wpcomV1dot1, "/me")
  end

  def my_sites() do
    Wpcom.Req.get(:wpcomV1dot2, "/me/sites")
  end
end
