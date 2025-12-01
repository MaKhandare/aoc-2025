defmodule Day01 do
  @start_pos 50

  def part1(input) do
    input
    |> parse_input()
    |> Enum.reduce({@start_pos, 0}, fn {dir, amount}, {current_pos, count} ->
      new_pos = next_pos(current_pos, dir, amount)
      new_count = if new_pos == 0, do: count + 1, else: count

      {new_pos, new_count}
    end)
    |> elem(1)
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.reduce({@start_pos, 0}, fn {dir, amount}, acc ->
      rotate(acc, dir, amount)
    end)
    |> elem(1)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      {dir, amount_str} = String.split_at(line, 1)
      {dir, String.to_integer(amount_str)}
    end)
  end

  defp next_pos(current, "L", amount), do: Integer.mod(current - amount, 100)
  defp next_pos(current, "R", amount), do: Integer.mod(current + amount, 100)

  # there must be a better way?
  defp rotate({start_pos, start_count}, dir, amount) do
    Enum.reduce(1..amount, {start_pos, start_count}, fn _, {pos, count} ->
      new_pos = next_pos(pos, dir, 1)

      new_count = if new_pos == 0, do: count + 1, else: count

      {new_pos, new_count}
    end)
  end
end

test_input = File.read!("test_input.txt")
input = File.read!("input.txt")

test_input |> Day01.part1() |> IO.inspect(label: "Part 1, Sample")
input |> Day01.part1() |> IO.inspect(label: "Part 1")

IO.puts("-----")

test_input |> Day01.part2() |> IO.inspect(label: "Part 2, Sample")
input |> Day01.part2() |> IO.inspect(label: "Part 2")
