defmodule Day01 do
  @start_pos 50
  @dial_size 100

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
    |> Enum.reduce({@start_pos, 0}, fn {dir, amount}, {current_pos, count} ->
      hits = count_zeros(current_pos, dir, amount)
      new_pos = next_pos(current_pos, dir, amount)

      {new_pos, count + hits}
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

  defp next_pos(current, "L", amount), do: Integer.mod(current - amount, @dial_size)
  defp next_pos(current, "R", amount), do: Integer.mod(current + amount, @dial_size)

  defp count_zeros(current, "R", amount) do
    calculate_hits(amount, @dial_size - current)
  end

  defp count_zeros(current, "L", amount) do
    dist = if current == 0, do: @dial_size, else: current
    calculate_hits(amount, dist)
  end

  defp calculate_hits(amount, dist_to_zero) do
    if amount >= dist_to_zero do
      1 + div(amount - dist_to_zero, @dial_size)
    else
      0
    end
  end
end

test_input = File.read!("test_input.txt")
input = File.read!("input.txt")

IO.puts("--- Part 1 ---")
test_input |> Day01.part1() |> IO.inspect(label: "Sample")
input |> Day01.part1() |> IO.inspect(label: "Result")

IO.puts("--- Part 2 ---")
test_input |> Day01.part2() |> IO.inspect(label: "Sample")
input |> Day01.part2() |> IO.inspect(label: "Result")

Benchee.run(%{
  :part1 => fn -> Day01.part1(input) end,
  :part2 => fn -> Day01.part2(input) end
})
