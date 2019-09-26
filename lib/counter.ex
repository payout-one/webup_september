defmodule Counter do
  use GenServer
  @table_country :country
  @table_country_count :country_count
  @info_after 5_000

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_) do
    :ets.new(@table_country, [
      :set,
      :named_table,
      :public,
      read_concurrency: true,
      write_concurrency: true
    ])

    :ets.new(@table_country_count, [
      :set,
      :named_table,
      :public,
      read_concurrency: true,
      write_concurrency: true
    ])

    schedule_info()
    {:ok, %{}}
  end

  def count_country(country) when is_binary(country) do
    :ets.update_counter(@table_country, country, {2, 1}, {country, 0})
    |> is_integer()
    |> if do
      :ets.update_counter(@table_country_count, :count, {2, 1}, {:count, 0})
    end
  end

  def handle_info(:info, state) do
    show_table()
    {:noreply, state}
  end

  def show_table() do
    IO.puts("\n-----------\n")

    :ets.tab2list(@table_country)
    |> Enum.sort(fn {_, a}, {_, b} -> b < a end)
    |> Enum.map(fn {country, count} ->
      [
        String.pad_leading(
          Integer.to_string(count),
          8
        ),
        " ",
        country,
        "\n"
      ]
    end)
    |> IO.binwrite()
  end

  def show_count() do
    IO.binwrite("-----------\n")

    count =
      case :ets.lookup(@table_country_count, :count) do
        [count: count] -> count
        [] -> 0
      end

    IO.binwrite("SUM#{String.pad_leading(Integer.to_string(count), 10)}\n")

    IO.binwrite("-----------\n")
  end

  defp schedule_info() do
    Process.send_after(self(), :info, @info_after)
  end
end
