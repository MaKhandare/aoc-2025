defmodule Day01 do
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

test_input |> Day01.part1() |> IO.inspect(label: "Part 1, Sample")
input |> Day01.part1() |> IO.inspect(label: "Part 1")

IO.puts("-----")

test_input |> Day01.part2() |> IO.inspect(label: "Part 2, Sample")
input |> Day01.part2() |> IO.inspect(label: "Part 2")
