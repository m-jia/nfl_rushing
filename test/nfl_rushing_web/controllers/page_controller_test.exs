defmodule NflRushingWeb.PageControllerTest do
  use NflRushingWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "NFL Players"
  end
end
