defmodule Enigma.Weather do
  @keys ~w(station_id longitude latitude elevation position_name gsnflag hcnflag city state state_code postal_code country country_code date_ prcp snow snwd tmax tmin awnd serialid latitude_longitude_appended)a
  defstruct @keys

  def keys(), do: @keys

  def from_map(raw) do
    a_map =
      @keys
      |> Enum.zip(raw)
      |> Enum.into(%{})

    processed_map =
      for key <- @keys, into: %{} do
        value = Map.get(a_map, key) || Map.get(a_map, to_string(key))
        {key, value}
      end

    Map.merge(%__MODULE__{}, processed_map)
  end
end

defimpl Enigma.Parser, for: Enigma.Weather do
  def load(type, enigma) do
    %{enigma | parsed: type.__struct__.from_map(enigma.raw)}
  end

  def get_country(%Enigma.Weather{country: country}), do: country
end
