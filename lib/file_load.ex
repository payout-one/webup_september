defmodule FileLoad do
  def run(type, path) do
    now = Timex.now()

    path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.map(fn line -> into_enigma(line, type) end)
    |> Enum.reject(&is_nil/1)
    |> Enum.map(&Enigma.load/1)
    |> Enum.map(&Enigma.get_country/1)
    |> Enum.each(&Counter.count_country/1)

    Counter.show_count()
    IO.puts("Time: #{Timex.diff(Timex.now(), now, :seconds)}")
  end

  def run_stream(type, path) do
    now = Timex.now()

    path
    |> File.stream!()
    |> Stream.map(&parse_line/1)
    |> Stream.map(fn line -> into_enigma(line, type) end)
    |> Stream.reject(&is_nil/1)
    |> Stream.map(&Enigma.load/1)
    |> Stream.map(&Enigma.get_country/1)
    |> Stream.each(&Counter.count_country/1)
    |> Stream.run()

    Counter.show_count()
    IO.puts("Time: #{Timex.diff(Timex.now(), now, :seconds)}")
  end

  def run_flow(type, path) do
    now = Timex.now()

    path
    |> File.stream!()
    |> Flow.from_enumerable()
    |> Flow.map(&parse_line/1)
    |> Flow.map(fn line -> into_enigma(line, type) end)
    |> Flow.reject(&is_nil/1)
    |> Flow.map(&Enigma.load/1)
    |> Flow.map(&Enigma.get_country/1)
    |> Flow.each(&Counter.count_country/1)
    |> Flow.run()

    Counter.show_count()
    IO.puts("Time: #{Timex.diff(Timex.now(), now, :seconds)}")
  end

  defp parse_line(stream_line) when is_bitstring(stream_line) do
    stream_line
    |> String.split(",")
  end

  defp into_enigma([], _type), do: nil

  defp into_enigma(parsed_line, type) when is_list(parsed_line) do
    Enigma.new(parsed_line, type)
  end

  defp into_enigma(_, _type), do: nil
end
