defmodule NflRushing.Repo.Players do
  alias NflRushing.Repo
  alias Repo.Schemas.Player

  import Ecto.Query

  def paginated_all_by(params \\ %{}) do
    name_term = "%#{Map.get(params, :player_name, "")}%"

    sort_by = params |> Map.get(:sort_by, "yds") |> String.to_atom()

    sort_term =
      case Map.get(params, :desc, true) do
        true -> [desc: sort_by]
        false -> [asc: sort_by]
      end

    page_term = [
      page: Map.get(params, :page, 1),
      page_size: Map.get(params, :page_size, 10)
    ]

    Player
    |> where([p], ilike(p.name, ^name_term))
    |> order_by(^sort_term)
    |> Repo.paginate(page_term)
  end
end
