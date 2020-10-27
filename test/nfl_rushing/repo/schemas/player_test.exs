defmodule NflRushing.Repo.Schemas.PlayerTest do
  use NflRushing.DataCase

  alias NflRushing.Repo.Schemas.Player

  describe "changeset/2" do
    test "can create a valid changeset" do
      changeset =
        Player.changeset(%{
          att: 2,
          att_g: Decimal.new("2"),
          avg: Decimal.new("3.5"),
          first: 0,
          first_percentage: Decimal.new("0"),
          fourty_plus: 0,
          fum: 0,
          id: 1,
          lng: 7,
          lng_t: false,
          name: "Joe Banyard",
          pos: "RB",
          td: 0,
          team: "JAX",
          twenty_plus: 0,
          yds: 7,
          yds_g: Decimal.new("7")
        })

      assert changeset.valid? == true
    end

    test "from_json converts data in json format" do
      json_data = %{
        "1st" => 0,
        "1st%" => 0,
        "20+" => 0,
        "40+" => 0,
        "Att" => 2,
        "Att/G" => 2,
        "Avg" => 3.5,
        "FUM" => 0,
        "Lng" => "7",
        "Player" => "Joe Banyard",
        "Pos" => "RB",
        "TD" => 0,
        "Team" => "JAX",
        "Yds" => 7,
        "Yds/G" => 7
      }

      attrs = Player.from_json(json_data)

      assert attrs.name == "Joe Banyard"
      assert attrs.lng == 7
      assert attrs.lng_t == false
    end
  end
end
