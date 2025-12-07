defmodule Day04 do
  @offsets for x <- -1..1, y <- -1..1, not (x == 0 and y == 0), do: {x, y}

  def part1(input) do
    grid = build_grid(input)
    Enum.count(grid, fn coord -> is_accessible?(grid, coord) end)
  end

  def part2(input) do
    grid = build_grid(input)
    remove_rolls(grid, 0)
  end

  defp remove_rolls(grid, count) do
    to_remove =
      Enum.filter(grid, fn coord -> is_accessible?(grid, coord) end)

    if Enum.empty?(to_remove) do
      count
    else
      new_grid = MapSet.difference(grid, MapSet.new(to_remove))
      remove_rolls(new_grid, count + length(to_remove))
    end
  end

  # TODO: something better here? revisit someday
  # binary comprehension maybe
  defp build_grid(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(MapSet.new(), fn {line, row}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn
        {"@", col}, set -> MapSet.put(set, {row, col})
        _, set -> set
      end)
    end)
  end

  defp is_accessible?(grid, coord) do
    neighbor_count(grid, coord) < 4
  end

  defp neighbor_count(grid, {r, c}) do
    Enum.count(@offsets, fn {dr, dc} ->
      MapSet.member?(grid, {r + dr, c + dc})
    end)
  end
end

sample_input = File.read!("inputs/Day04_sample_input.txt")
input = File.read!("inputs/Day04_input.txt")

IO.puts("--- Part 1 ---")
sample_input |> Day04.part1() |> IO.inspect(label: "Sample")
input |> Day04.part1() |> IO.inspect(label: "Result")

IO.puts("--- Part 2 ---")
sample_input |> Day04.part2() |> IO.inspect(label: "Sample")
input |> Day04.part2() |> IO.inspect(label: "Result")

Benchee.run(%{
  :part1 => fn -> Day04.part1(input) end,
  :part2 => fn -> Day04.part2(input) end
})
