defmodule NflRushingWeb.Schema do
  use Absinthe.Schema

  import_types(NflRushingWeb.Types.Players)

  query do
    field :players, :players do
      arg(:player_name, :string)
      arg(:sort_by, :string)
      arg(:desc, :boolean)
      arg(:page, :integer)
      arg(:page_size, :integer)

      resolve(&NflRushingWeb.Resolvers.Player.all/2)
    end
  end

  # def context(ctx) do
  #   source = Dataloader.Ecto.new(NflRushing.Repo)
  #   dataloader = Dataloader.add_source(Dataloader.new(), NflRushing.Accounts, source)

  #   Map.put(ctx, :loader, dataloader)
  # end

  # def plugins do
  #   [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  # end
end
