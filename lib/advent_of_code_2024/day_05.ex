defmodule AdventOfCode2024.Day05 do
  def part1() do
    {rules, updates} = load_file()

    updates
    |> Enum.filter(&check_rule(rules, &1))
    |> Enum.reduce(0, fn x, acc ->
      acc + Enum.at(x, div(length(x), 2))
    end)
  end

  def part2() do
    {rules, updates} = load_file()

    updates
    |> Enum.reject(&check_rule(rules, &1))
    |> Enum.map(&fix_update(rules, &1))
    |> Enum.map(&Enum.at(&1, div(length(&1), 2)))
    |> Enum.sum()
  end

  def load_file() do
    [rule_strings, update_strings] =
      File.read!("lib/advent_of_code_2024/day_05_sample_input.txt")
      |> String.split("\n", trim: true)
      |> Enum.chunk_by(&String.contains?(&1, "|"))

    rules =
      rule_strings
      |> Enum.map(&String.split(&1, "|"))
      |> Enum.map(fn r -> Enum.map(r, &String.to_integer/1) end)
      |> Enum.reduce(%{}, fn [b, a], rules_map ->
        Map.put(rules_map, b, (rules_map[b] || []) ++ [a])
      end)

    updates =
      update_strings
      |> Enum.map(&String.split(&1, ","))
      |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)

    {rules, updates}
  end

  def check_rule(rules, update) do
    update
    |> Enum.with_index()
    |> Enum.all?(fn {v, i} ->
      update
      |> Enum.slice((i + 1)..-1//1)
      |> Enum.all?(&Enum.member?(rules[v] || [], &1))
      |> Enum.all?(&(&1 in (rules[v] || [])))
    end)
  end

  def fix_update(rules, update) do
    rules
    |> Map.filter(&(elem(&1, 0) in update))
    |> Enum.map(fn {k, v} -> {k, v |> Enum.filter(&(&1 in update))} end)
    |> Enum.sort_by(fn {_, v} -> length(v) end, :desc)
    |> Enum.map(fn {k, _} -> k end)
  end
end
