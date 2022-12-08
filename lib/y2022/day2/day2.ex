defmodule Aoc.Y2022.Day2 do
  @plays %{"A" => :roc, "B" => :pap, "C" => :sci, "X" => :roc, "Y" => :pap, "Z" => :sci}
  @orders %{"X" => :lose, "Y" => :draw, "Z" => :win}

  @play_score %{roc: 1, pap: 2, sci: 3}

  def solve1 do
    data()
    |> Enum.map(&play1/1)
    |> Enum.sum()
  end

  def solve2 do
    data()
    |> Enum.map(&play2/1)
    |> Enum.sum()
  end

  defp data do
    "./lib/y2022/day2/data.txt"
    |> File.read!()
    |> String.split("\n")
  end

  defp play1(<<p2::binary-size(1)>> <> " " <> <<p1::binary-size(1)>>) do
    total_score(@plays[p1], @plays[p2])
  end

  defp play2(<<p2::binary-size(1)>> <> " " <> <<order::binary-size(1)>>) do
    @plays[p2]
    |> play_order(@orders[order])
    |> total_score(@plays[p2])
  end

  defp play_order(:roc, :lose), do: :sci
  defp play_order(:roc, :draw), do: :roc
  defp play_order(:roc, :win), do: :pap
  defp play_order(:pap, :lose), do: :roc
  defp play_order(:pap, :draw), do: :pap
  defp play_order(:pap, :win), do: :sci
  defp play_order(:sci, :lose), do: :pap
  defp play_order(:sci, :draw), do: :sci
  defp play_order(:sci, :win), do: :roc

  defp total_score(p1, p2), do: outcome_score(p1, p2) + @play_score[p1]

  defp outcome_score(:roc, :roc), do: 3
  defp outcome_score(:roc, :pap), do: 0
  defp outcome_score(:roc, :sci), do: 6
  defp outcome_score(:pap, :roc), do: 6
  defp outcome_score(:pap, :pap), do: 3
  defp outcome_score(:pap, :sci), do: 0
  defp outcome_score(:sci, :roc), do: 0
  defp outcome_score(:sci, :pap), do: 6
  defp outcome_score(:sci, :sci), do: 3
end
