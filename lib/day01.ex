defmodule Day01 do
  def part1(input) do
    initial = {50, 0}

    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(initial, fn line, {pos, count} ->
      {direction, amount_str} = String.split_at(line, 1)

      amount = String.to_integer(amount_str)
      new_pos = calculate_position(pos, direction, amount)

      new_count = if new_pos == 0, do: count + 1, else: count

      {new_pos, new_count}
    end)
    |> elem(1)
  end

  def part2(input) do
    initial = {50, 0}

    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(initial, fn line, {pos, count} ->
      {direction, amount_str} = String.split_at(line, 1)
      amount = String.to_integer(amount_str)

      rotate(pos, count, direction, amount)
    end)
    |> elem(1)
  end

  defp calculate_position(current, "L", amount) do
    Integer.mod(current - amount, 100)
  end

  defp calculate_position(current, "R", amount) do
    Integer.mod(current + amount, 100)
  end

  defp rotate(start_pos, start_count, direction, amount) do
    Enum.reduce(1..amount, {start_pos, start_count}, fn _, {pos, count} ->
      new_pos =
        case direction do
          "L" -> Integer.mod(pos - 1, 100)
          "R" -> Integer.mod(pos + 1, 100)
        end

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
