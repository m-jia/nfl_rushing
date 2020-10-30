defmodule NflRushing.Repo.PlayersTest do
  use NflRushing.DataCase

  alias NflRushing.Repo.Players

  setup do
    player1 = insert(:player, %{name: "Tony First", yds: 15, avg: 1.2})
    player2 = insert(:player, %{name: "George Second", yds: 100, avg: 3.5})
    player3 = insert(:player, %{name: "Thomas Third", yds: -5, avg: -0.1})

    %{p1: player1, p2: player2, p3: player3}
  end

  test "paginated_all_by/1 reurns players with default sort and paginate settings", ctx do
    page = Players.paginated_all_by()

    verify_page_result(page, 3, ctx.p2.name, 3, 1)
  end

  test "paginated_all_by/1 can filter players with partial player name", ctx do
    page = Players.paginated_all_by(%{player_name: "third"})

    verify_page_result(page, 1, ctx.p3.name, 1, 1)
  end

  test "paginated_all_by/1 can sort players by specific field", ctx do
    page = Players.paginated_all_by(%{sort_by: "avg", desc: false})

    verify_page_result(page, 3, ctx.p3.name, 3, 1)
  end

  test "paginated_all_by/1 can return players by specific pagination parameters", ctx do
    page = Players.paginated_all_by(%{page_size: 2, page: 2})

    verify_page_result(page, 1, ctx.p3.name, 3, 2, 2, 2)
  end

  test "paginated_all_by/1 will return all players if return_all is true, ignore any pagination parameters",
       ctx do
    page = Players.paginated_all_by(%{return_all: true, page_size: 2, page: 2})

    verify_page_result(page, 3, ctx.p2.name, 3, 1, 1, 3)
  end

  defp verify_page_result(
         page,
         page_entries,
         first_player_name,
         total_entries,
         total_pages,
         page_number \\ 1,
         page_size \\ 10
       ) do
    assert page.total_entries == total_entries
    assert page.total_pages == total_pages
    assert page.page_number == page_number
    assert page.page_size == page_size

    assert length(page.entries) == page_entries
    assert List.first(page.entries).name == first_player_name
  end
end
