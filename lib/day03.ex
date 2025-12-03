defmodule Day03 do
  def part1(input) do
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

  defp get_max_joltage(line, target_length) do
    digits = for <<byte <- line>>, byte, do: byte - ?0

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
  :part2 => fn -> Day03.part2(input) end
})
