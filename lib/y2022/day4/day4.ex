defmodule Aoc.Y2022.Day4 do
  def solve1 do
    data()
    |> Stream.map(&to_integer_tuple/1)
    |> Stream.map(&contains?/1)
    |> Enum.sum()
  end

  def solve2 do
    data()
    |> Stream.map(&to_integer_tuple/1)
    |> Stream.map(&overlaps?/1)
    |> Enum.sum()
  end

  defp data do
    "./lib/y2022/day4/data.txt"
    |> File.read!()
    |> String.split(~r/[\n,]/)
    |> Stream.map(&String.split(&1, "-"))
    |> Stream.chunk_every(2)
  end

  defp to_integer_tuple([[a, b], [c, d]]) do
    {{String.to_integer(a), String.to_integer(b)}, {String.to_integer(c), String.to_integer(d)}}
  end

  defp contains?({{a, b}, {c, d}}) when (c >= a and d <= b) or (a >= c and b <= d), do: 1
  defp contains?(_), do: 0

  defp overlaps?({{a, b}, {c, d}}) when a in c..d or b in c..d or c in a..b or d in a..b, do: 1
  defp overlaps?(_), do: 0
end
