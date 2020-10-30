# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NflRushing.Repo.insert!(%NflRushing.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias NflRushing.Repo
alias Repo.Schemas.Player

if !NflRushing.Repo.exists?(NflRushing.Repo.Schemas.Player) do
  priv_dir = :code.priv_dir(:nfl_rushing)

  players =
    "#{priv_dir}/repo/seeds/rushing.json"
    |> File.read!()
    |> Jason.decode!()

  Enum.each(players, fn p ->
    p
    |> Player.from_json()
    |> Player.changeset()
    |> Repo.insert!()
  end)
end
