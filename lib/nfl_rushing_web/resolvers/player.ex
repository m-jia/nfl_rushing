defmodule NflRushingWeb.Resolvers.Player do
  alias NflRushing.Repo.Players

  def all(params, _) do
    {:ok, Players.paginated_all_by(params)}
  end
end
