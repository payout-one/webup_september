defmodule Enigma do
  alias Enigma.Parser

  defstruct [:raw, :parsed, :type]

  def new(line, type) do
    %__MODULE__{raw: line, type: type}
  end

  def load(enigma), do: Parser.load(enigma.type, enigma)
  def get_country(enigma), do: Parser.get_country(enigma.parsed)
end
