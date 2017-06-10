defmodule Bravado.Web.PageControllerTest do
  use Bravado.Web.ConnCase

  setup do
    on_exit fn ->
      Bravado.RateLimiter.reset()
    end

    :ok
  end

  test "get page path", %{conn: conn} do
    conn = get conn, page_path(conn, :index)

    assert json_response(conn, 200) == %{"status" => "ok"}
  end

  test "get page path more than maximum rate limit", %{conn: conn} do
    for _ <- 1..5 do
      get conn, page_path(conn, :index)
    end

    conn = get conn, page_path(conn, :index)

    assert json_response(conn, 429) == %{"status" => "error"}
  end
end
