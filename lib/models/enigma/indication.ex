defmodule Enigma.Indication do
  @keys ~w(id date element element_trans latitude longitude state name value mflag qflag sflag serialid latitude_longitude_appended)a
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

defimpl Enigma.Parser, for: Enigma.Indication do
  def load(type, enigma) do
    %{enigma | parsed: type.__struct__.from_map(enigma.raw)}
  end

  def get_country(%Enigma.Indication{state: state}), do: state
end
