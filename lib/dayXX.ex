defmodule DayXX do
  def part1(input) do
    input
  end

  def part2(input) do
    input
  end
end

test_input = File.read!("test_input.txt")
input = File.read!("input.txt")

IO.puts("--- Part 1 ---")
test_input |> DayXX.part1() |> IO.inspect(label: "Sample")
input |> DayXX.part1() |> IO.inspect(label: "Result")

IO.puts("--- Part 2 ---")
test_input |> DayXX.part2() |> IO.inspect(label: "Sample")
input |> DayXX.part2() |> IO.inspect(label: "Result")
