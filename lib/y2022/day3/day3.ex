defmodule Aoc.Y2022.Day3 do
  def solve1 do
    data()
    |> Stream.map(&split_rucksack/1)
    |> Stream.map(&find_duplicate/1)
    |> Stream.map(&adjust_priority/1)
    |> Enum.sum()
  end

  def solve2 do
    data()
    |> Stream.chunk_every(3)
    |> Stream.map(&find_duplicate/1)
    |> Stream.map(&adjust_priority/1)
    |> Enum.sum()
  end

  defp data do
    "./lib/y2022/day3/data.txt"
    |> File.open!([:charlist])
    |> IO.read(:eof)
    |> Enum.chunk_by(&(&1 == 10))
    |> Enum.filter(&(&1 != [10]))
  end

  defp split_rucksack(lst), do: Enum.chunk_every(lst, div(length(lst), 2))

  defp find_duplicate([c1, c2]) do
    Enum.reduce_while(c1, '', &if(Enum.member?(c2, &1), do: {:halt, &1}, else: {:cont, &2}))
  end

  defp find_duplicate([c1, c2, c3]) do
    Enum.reduce_while(
      c1,
      '',
      &if(Enum.member?(c2, &1) and Enum.member?(c3, &1), do: {:halt, &1}, else: {:cont, &2})
    )
  end

  def adjust_priority(n) when n in ?a..?z, do: n - 96
  def adjust_priority(n) when n in ?A..?Z, do: n - 38
end
