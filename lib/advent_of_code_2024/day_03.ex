defmodule AdventOfCode2024.Day03 do
  import AdventOfCode2024.Utils

  def part1() do
    File.open("lib/advent_of_code_2024/day_03_input.txt")
    |> read_from_file
    |> multiply_from_input()
  end

  def part2() do
    File.open("lib/advent_of_code_2024/day_03_input.txt")
    |> read_from_file
    |> String.replace(~r/don't\(\)[\s\S]+?(do\(\)|$)/, "")
    |> multiply_from_input()
  end

  defp multiply_from_input(input) do
    Regex.scan(~r/mul\((\d+),(\d+)\)/, input, capture: :all_but_first)
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
    |> Enum.map(fn [a, b] -> a * b end)
    |> Enum.sum()
  end
end
