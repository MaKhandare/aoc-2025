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
      Enum.reduce(digits, {[], removals_allowed}, &update_stack/2)

    stack
    |> Enum.reverse()
    |> Enum.take(target_length)
    |> Integer.undigits()
  end

  defp update_stack(digit, {[], removals}), do: {[digit], removals}

  defp update_stack(digit, {[top | rest], removals}) when removals > 0 and digit > top do
    update_stack(digit, {rest, removals - 1})
  end

  defp update_stack(digit, {stack, removals}) do
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
