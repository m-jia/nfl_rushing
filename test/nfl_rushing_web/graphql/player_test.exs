defmodule NflRushingWeb.Graphql.PlayerTest do
  use NflRushingWeb.ConnCase

  test "get all players sorted by yds in descending order by defaut" do
    insert(:player, %{name: "Tony First", yds: 15})
    p = insert(:player, %{name: "George Second", yds: 100})
    insert(:player, %{name: "Thomas Third", yds: -5})

    query = """
    query{
      players{
        pageSize
        pageNumber
        totalEntries
        totalPages
        entries {
          id
          name
          team
          pos
          yds
          ydsG
          td
          avg
          lng
          lngT
          first
          firstPercentage
          twentyPlus
          fourtyPlus
          fum
        }
      }
    }
    """

    body =
      build_conn()
      |> put_req_header("content-type", "json")
      |> post("/graphql", query)
      |> json_response(200)

    response = get_in(body, ["data", "players"])
    players = get_in(response, ["entries"])
    first = List.first(players)

    assert response["totalEntries"] == 3
    assert response["totalPages"] == 1
    assert response["pageNumber"] == 1
    assert response["pageSize"] == 10

    assert is_list(players)
    assert length(players) == 3
    assert first["name"] == p.name
  end
end
