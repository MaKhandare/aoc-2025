defmodule Day02 do
  def part1(input) do
    input
    |> parse_input()
    |> Enum.flat_map(&get_invalid_ids/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.flat_map(&get_invalid_ids_part2/1)
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> String.replace("\n", "")
    |> String.split(",", trim: true)
    |> Enum.map(&parse_range/1)
  end

  defp parse_range(range_str) do
    [from, to] = String.split(range_str, "-", trim: true)
    {from, to}
  end

  defp get_invalid_ids({from, to}) do
    String.to_integer(from)..String.to_integer(to)
    |> Enum.filter(&has_repeated_sequence?/1)
  end

  defp has_repeated_sequence?(num) do
    str = Integer.to_string(num)
    len = String.length(str)

    if rem(len, 2) != 0 do
      false
    else
      half_index = div(len, 2)
      {left, right} = String.split_at(str, half_index)
      left == right
    end
  end

  defp get_invalid_ids_part2({from, to}) do
    String.to_integer(from)..String.to_integer(to)
    |> Enum.filter(&is_repeating_at_least_twice?/1)
  end

  defp is_repeating_at_least_twice?(num) do
    str = Integer.to_string(num)
    len = String.length(str)

    if len < 2 do
      false
    else
      1..div(len, 2)
      |> Enum.any?(fn sub_len ->
        rem(len, sub_len) == 0 and check_repetition(str, sub_len, len)
      end)
    end
  end

  defp check_repetition(str, sub_len, total_len) do
    pattern = String.slice(str, 0, sub_len)
    repeats_needed = div(total_len, sub_len)

    String.duplicate(pattern, repeats_needed) == str
  end
end

test_input = File.read!("test_input.txt")
input = File.read!("input.txt")

IO.puts("--- Part 1 ---")
test_input |> Day02.part1() |> IO.inspect(label: "Sample")
input |> Day02.part1() |> IO.inspect(label: "Result")

IO.puts("--- Part 2 ---")
test_input |> Day02.part2() |> IO.inspect(label: "Sample")
input |> Day02.part2() |> IO.inspect(label: "Result")

Benchee.run(%{
  :part1 => fn -> Day02.part1(input) end,
  :part2 => fn -> Day02.part2(input) end
})
