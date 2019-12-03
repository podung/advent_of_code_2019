defmodule Aoc2019Utils do
  def split_lines(input), do: String.split(input, "\n", trim: true)

  def parse_ints(input) do
    input
    |> String.trim
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
