defmodule NflRushing.Test.Support.Factory do
  @moduledoc "Entrypoint for factories"

  alias NflRushing.Repo
  use ExMachina.Ecto, repo: Repo

  def player_factory do
    %Repo.Schemas.Player{
      att: 2,
      att_g: Decimal.new("2"),
      avg: Decimal.new("3.5"),
      first: 0,
      first_percentage: Decimal.new("0"),
      fourty_plus: 0,
      fum: 0,
      lng: 7,
      lng_t: false,
      name: "John Doe",
      pos: "RB",
      td: 0,
      team: "JAX",
      twenty_plus: 0,
      yds: 7,
      yds_g: Decimal.new("7")
    }
  end
end
