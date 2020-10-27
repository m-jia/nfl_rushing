defmodule NflRushing.Repo.Migrations.AddPlayersTable do
  use Ecto.Migration

  def change do
    create table(:players) do
      add(:name, :string, null: false)
      add(:team, :string, null: false)
      add(:pos, :string)
      add(:att_g, :decimal)
      add(:att, :integer)
      add(:yds, :integer)
      add(:avg, :decimal)
      add(:yds_g, :decimal)
      add(:td, :integer)
      add(:lng, :integer)
      add(:lng_t, :boolean, default: false)
      add(:first, :integer)
      add(:first_percentage, :decimal)
      add(:twenty_plus, :integer)
      add(:fourty_plus, :integer)
      add(:fum, :integer)
      timestamps()
    end

    create index(:players, [:yds])
    create index(:players, [:lng])
    create index(:players, [:td])
  end
end
