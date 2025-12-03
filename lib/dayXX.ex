defmodule DayXX do
  def part1(input) do
    input
  end

  def part2(input) do
    input
  end
end

sample_input = File.read!("inputs/DayXX_sample_input.txt")
input = File.read!("inputs/DayXX_input.txt")

IO.puts("--- Part 1 ---")
sample_input |> DayXX.part1() |> IO.inspect(label: "Sample")
input |> DayXX.part1() |> IO.inspect(label: "Result")

IO.puts("--- Part 2 ---")
sample_input |> DayXX.part2() |> IO.inspect(label: "Sample")
input |> DayXX.part2() |> IO.inspect(label: "Result")

# Benchee.run(%{
#   :part1 => fn -> DayXX.part1(input) end,
#   :part2 => fn -> DayXX.part2(input) end
# })
