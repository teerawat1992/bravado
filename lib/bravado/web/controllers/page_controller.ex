defmodule Bravado.Web.PageController do
  use Bravado.Web, :controller

  def index(conn, _params) do
    json(conn, %{status: "ok"})
  end
end
