defmodule NflRushing.Repo.Schemas.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field(:name, :string, required: true)
    field(:team, :string, required: true)
    field(:pos, :string)
    field(:att_g, :decimal)
    field(:att, :integer)
    field(:yds, :integer)
    field(:avg, :decimal)
    field(:yds_g, :decimal)
    field(:td, :integer)
    field(:lng, :integer)
    field(:lng_t, :boolean, default: false)
    field(:first, :integer)
    field(:first_percentage, :decimal)
    field(:twenty_plus, :integer)
    field(:fourty_plus, :integer)
    field(:fum, :integer)

    timestamps()
  end

  @required_fields ~w(name team)a

  @allowed_fields ~w(pos att_g att yds avg yds_g td lng lng_t first first_percentage twenty_plus fourty_plus fum)a ++
                    @required_fields

  def changeset(struct \\ %__MODULE__{}, attrs) do
    struct
    |> cast(attrs, @allowed_fields)
    |> validate_required(@required_fields)
  end

  def from_json(p) do
    {lng, lng_t} = convert_lng(p["Lng"])

    %{
      name: p["Player"],
      team: p["Team"],
      pos: p["Pos"],
      att_g: to_dec(p["Att/G"]),
      att: to_int(p["Att"]),
      yds: to_int(p["Yds"]),
      avg: to_dec(p["Avg"]),
      yds_g: to_dec(p["Yds/G"]),
      td: to_int(p["TD"]),
      lng: lng,
      lng_t: lng_t,
      first: to_int(p["1st"]),
      first_percentage: to_dec(p["1st%"]),
      twenty_plus: to_int(p["20+"]),
      fourty_plus: to_int(p["40+"]),
      fum: to_int(p["FUM"])
    }
  end

  defp to_int(s) when is_binary(s), do: s |> String.replace(",", "") |> String.to_integer()
  defp to_int(i) when is_integer(i), do: i
  defp to_int(_), do: 0

  defp to_dec(s) when is_binary(s), do: s |> String.replace(",", "") |> Decimal.new()
  defp to_dec(d) when is_float(d), do: d
  defp to_dec(d) when is_integer(d), do: d
  defp to_dec(_), do: Decimal.new("0")

  defp convert_lng(l) when is_binary(l) do
    case String.ends_with?(l, "T") do
      true -> {l |> String.replace("T", "") |> to_int, true}
      _ -> {to_int(l), false}
    end
  end

  defp convert_lng(l), do: {to_int(l), false}
end
