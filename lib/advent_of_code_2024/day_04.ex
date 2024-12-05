defmodule AdventOfCode2024.Day04 do
  def part1() do
    map = load_file_into_map()

    Enum.reduce(map, 0, fn {x, y_row}, acc ->
      Enum.reduce(y_row, acc, fn {y, letter}, acc2 ->
        if letter == "X" do
          acc2 + count_xmas(map, {x, y})
        else
          acc2
        end
      end)
    end)
  end

  def part2() do
    map = load_file_into_map()

    Enum.reduce(map, 0, fn {x, y_row}, acc ->
      Enum.reduce(y_row, acc, fn {y, letter}, acc2 ->
        if letter == "A" do
          acc2 + count_x_mas(map, {x, y})
        else
          acc2
        end
      end)
    end)
  end

  def load_file_into_map() do
    File.read!("lib/advent_of_code_2024/day_04_input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&create_map_from_string/1)
    |> Enum.with_index()
    |> Enum.map(fn {v, k} -> {k, v} end)
    |> Map.new()
  end

  def create_map_from_string(string) do
    string
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.map(fn {v, k} -> {k, v} end)
    |> Map.new()
  end

  def count_x_mas(map, {x, y}) do
    if ((map[x - 1][y - 1] == "M" and map[x + 1][y + 1] == "S") or
          (map[x - 1][y - 1] == "S" and map[x + 1][y + 1] == "M")) and
         ((map[x + 1][y - 1] == "M" and map[x - 1][y + 1] == "S") or
            (map[x + 1][y - 1] == "S" and map[x - 1][y + 1] == "M")) do
      1
    else
      0
    end
  end

  def count_xmas(map, {x, y}) do
    directions = [
      {1, 0},
      {1, 1},
      {0, 1},
      {-1, 1},
      {-1, 0},
      {-1, -1},
      {0, -1},
      {1, -1}
    ]

    directions
    |> Enum.reduce(0, fn {dx, dy}, acc ->
      if map[x + dx][y + dy] == "M" and map[x + 2 * dx][y + 2 * dy] == "A" and
           map[x + 3 * dx][y + 3 * dy] == "S",
         do: acc + 1,
         else: acc
    end)
  end
end
