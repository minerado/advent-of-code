defmodule Aoc.Y2022.Day1 do
  def solve1, do: cals() |> Enum.sort(:desc) |> List.first()
  def solve2, do: cals() |> Enum.sort(:desc) |> Enum.take(3) |> Enum.sum()

  defp cals do
    File.read!("./lib/y2022/day1/data.txt")
    |> String.split("\n")
    |> Stream.chunk_by(&(&1 == ""))
    |> Stream.filter(&(&1 != [""]))
    |> Stream.map(fn l -> Enum.map(l, &String.to_integer/1) end)
    |> Stream.map(&Enum.sum/1)
  end
end
