defmodule DayXX do
  def part1(input) do
    input
    |> IO.puts()
  end

  def part2(input) do
    input
    |> IO.puts()
  end
end

test_input = File.read!("test_input.txt")
input = File.read!("input.txt")

test_input |> DayXX.part1() |> IO.inspect(label: "Part 1, Sample")
input |> DayXX.part1() |> IO.inspect(label: "Part 1")

IO.puts("-----")

test_input |> DayXX.part2() |> IO.inspect(label: "Part 2, Sample")
input |> DayXX.part2() |> IO.inspect(label: "Part 2")
