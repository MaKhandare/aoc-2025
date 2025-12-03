defmodule Day03 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&get_max_joltage/1)
    |> Enum.sum()
  end

  def part1_with_stack(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&get_max_joltage(&1, 2))
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&get_max_joltage(&1, 12))
    |> Enum.sum()
  end

  defp get_max_joltage(line) do
    digits =
      line
      |> String.to_charlist()
      |> Enum.map(&(&1 - ?0))

    find_highest_joltage(digits, 9)
  end

  defp find_highest_joltage(digits, candidate) do
    case Enum.split_while(digits, fn d -> d != candidate end) do
      {_, []} ->
        find_highest_joltage(digits, candidate - 1)

      {_, [_ | []]} ->
        find_highest_joltage(digits, candidate - 1)

      {_, [_ | rest]} ->
        candidate * 10 + Enum.max(rest)
    end
  end

  defp get_max_joltage(line, target_length) do
    digits =
      line
      |> String.to_charlist()
      |> Enum.map(&(&1 - ?0))

    removals_allowed = length(digits) - target_length

    {stack, _} =
      Enum.reduce(digits, {[], removals_allowed}, fn digit, acc ->
        update_stack(acc, digit)
      end)

    stack
    |> Enum.reverse()
    |> Enum.take(target_length)
    |> Integer.undigits()
  end

  defp update_stack({[top | rest], removals}, digit) when removals > 0 and digit > top do
    update_stack({rest, removals - 1}, digit)
  end

  defp update_stack({stack, removals}, digit) do
    {[digit | stack], removals}
  end
end

sample_input = File.read!("inputs/Day03_sample_input.txt")
input = File.read!("inputs/Day03_input.txt")

IO.puts("--- Part 1 ---")
sample_input |> Day03.part1() |> IO.inspect(label: "Sample")
input |> Day03.part1() |> IO.inspect(label: "Result")

IO.puts("--- Part 2 ---")
sample_input |> Day03.part2() |> IO.inspect(label: "Sample")
input |> Day03.part2() |> IO.inspect(label: "Result")

Benchee.run(%{
  :part1 => fn -> Day03.part1(input) end,
  :part1_with_stack => fn -> Day03.part1_with_stack(input) end,
  :part2 => fn -> Day03.part2(input) end
})
