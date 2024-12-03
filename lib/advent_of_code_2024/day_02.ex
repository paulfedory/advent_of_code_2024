defmodule AdventOfCode2024.Day02 do
  import AdventOfCode2024.Utils

  def part1() do
    File.open("lib/advent_of_code_2024/day_02_input.txt")
    |> read_from_file
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
    |> Enum.filter(&is_safe?/1)
    |> Enum.count()
    |> dbg()
  end

  def is_safe?(list) do
    is_all_increasing_and_safe?(list) or is_all_decreasing_and_safe?(list)
  end

  def is_all_increasing_and_safe?([_x]), do: true

  def is_all_increasing_and_safe?([head | tail]) do
    if head < hd(tail) and hd(tail) - head <= 3 do
      is_all_increasing_and_safe?(tail)
    else
      false
    end
  end

  def is_all_decreasing_and_safe?([_x]), do: true

  def is_all_decreasing_and_safe?([head | tail]) do
    if head > hd(tail) and head - hd(tail) <= 3 do
      is_all_decreasing_and_safe?(tail)
    else
      false
    end
  end

  def part2() do
    File.open("lib/advent_of_code_2024/day_02_input.txt")
    |> read_from_file
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
    |> Enum.filter(&is_safe_with_removal?/1)
    |> Enum.count()
    |> dbg()
  end

  def is_safe_with_removal?(list) do
    if is_safe?(list) do
      true
    else
      list
      |> Enum.with_index()
      |> Enum.any?(fn {_x, i} -> is_safe?(List.delete_at(list, i)) end)
    end
  end
end
