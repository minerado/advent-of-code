defmodule Aoc.Y2022.Day1 do
  @moduledoc false

  @doc false
  @spec solve1() :: pos_integer()
  def solve1, do: get_max_calories(data())

  @doc false
  @spec solve2() :: pos_integer()
  def solve2, do: get_max_calories(data(), 3)

  defp data do
    File.read!("./lib/y2022/day-1/day1-data.txt")
    |> String.split("\n\n")
    |> Enum.map(fn x ->
      x
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp map_by_total(list), do: Enum.map(list, &Enum.sum/1)

  defp get_max_calories(data, n \\ 1) do
    data
    |> map_by_total()
    |> Enum.sort(:desc)
    |> Enum.take(n)
    |> Enum.sum()
  end
end
