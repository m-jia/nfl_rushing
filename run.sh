sleep 15s

mix ecto.setup
mix ecto.migrate
mix run priv/repo/seeds.exs

mix phx.server