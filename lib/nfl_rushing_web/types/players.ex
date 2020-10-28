defmodule NflRushingWeb.Types.Players do
  use Absinthe.Schema.Notation

  import_types(NflRushingWeb.Types.Player)

  @desc "Players"
  object :players do
    field(:entries, list_of(:player))
    field(:total_entries, :integer)
    field(:total_pages, :integer)
    field(:page_number, :integer)
    field(:page_size, :integer)
  end
end
