defmodule AdventOfCode2024.Day01 do
  import AdventOfCode2024.Utils

  def part1() do
    [list1, list2] =
      File.open("lib/advent_of_code_2024/day_01_input.txt")
      |> read_from_file
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split/1)
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
      |> Enum.map(&Enum.sort/1)

    Enum.zip(list1, list2)
    |> Enum.map(fn {x, y} -> abs(x - y) end)
    |> Enum.sum()
  end

  def part2() do
    [list1, list2] =
      File.open("lib/advent_of_code_2024/day_01_input.txt")
      |> read_from_file
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split/1)
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
      |> Enum.map(&Enum.sort/1)

    freq = Enum.frequencies(list2)

    list1
    |> Enum.map(fn x -> x * (freq[x] || 0) end)
    |> Enum.sum()
  end
end
