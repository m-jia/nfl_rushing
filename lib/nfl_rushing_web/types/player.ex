defmodule NflRushingWeb.Types.Player do
  use Absinthe.Schema.Notation
  import_types(Absinthe.Type.Custom)

  @desc "Player"
  object :player do
    field(:id, :id)
    field(:name, :string)
    field(:team, :string)
    field(:pos, :string)
    field(:att_g, :decimal)
    field(:att, :integer)
    field(:yds, :integer)
    field(:avg, :decimal)
    field(:yds_g, :decimal)
    field(:td, :integer)
    field(:lng, :integer)
    field(:lng_t, :boolean)
    field(:first, :integer)
    field(:first_percentage, :decimal)
    field(:twenty_plus, :integer)
    field(:fourty_plus, :integer)
    field(:fum, :integer)
  end
end
