defmodule Aoc.Y2022.Day5 do
  @moves_regex ~r/move (?<crates>\d+) from (?<from>\d+) to (?<to>\d+)/
  def solve1 do
    case data() do
      {stack, actions} ->
        actions
        |> Enum.reduce(stack, &move_1(&2, &1))
        |> Enum.map(fn {_, [h | _]} -> h end)
    end
  end

  def solve2 do
    case data() do
      {stack, actions} ->
        actions
        |> Enum.reduce(stack, &move_n(&2, &1))
        |> Enum.map(fn {_, [h | _]} -> h end)
    end
  end

  defp data do
    with <<table::binary-size(288), _::binary-size(37), orders::binary>> <-
           File.read!("./lib/y2022/day5/data.txt"),
         stacks <-
           table
           |> String.split(~r/(\[.\]\s)|(\s{4})/, include_captures: true, trim: true)
           |> Stream.map(fn <<_::binary-size(1), x::binary-size(1), _rest::binary>> -> x end)
           |> Stream.with_index()
           |> Enum.group_by(fn {_, i} -> rem(i, 9) + 1 end, fn {x, _} -> x end)
           |> Enum.map(fn {k, v} -> {k, Enum.filter(v, &(&1 != " "))} end)
           |> Map.new(),
         actions <-
           orders
           |> String.split("\n")
           |> Enum.map(&Regex.named_captures(@moves_regex, &1)) do
      {stacks, actions}
    end
  end

  def move_1(stacks, %{} = action), do: move_1(stacks, action_integers(action))
  def move_1(stacks, {_, _, 0}), do: stacks

  def move_1(stacks, {from, to, times}) do
    case {stacks[from], times} do
      {[], _} -> stacks
      {[h | t], _} -> move_1(%{stacks | from => t, to => [h | stacks[to]]}, {from, to, times - 1})
    end
  end

  def move_n(stacks, %{} = action), do: move_n(stacks, action_integers(action))

  def move_n(stacks, {from, to, n}) do
    with {h, t} <- Enum.split(stacks[from], n) do
      %{stacks | from => t, to => h ++ stacks[to]}
    end
  end

  defp action_integers(%{"crates" => crates, "from" => from, "to" => to}) do
    {String.to_integer(from), String.to_integer(to), String.to_integer(crates)}
  end
end
