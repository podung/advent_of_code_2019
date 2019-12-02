defmodule Day01Test do
  use ExUnit.Case

  import Aoc2019Utils

  test "calculates sample fuels correctly" do
    assert Day01.fuel(12)     == 2
    assert Day01.fuel(14)     == 2
    assert Day01.fuel(1969)   == 654
    assert Day01.fuel(100756) == 33583

    assert Day01.fuel_sum([12, 14, 1969, 100756]) == 34241
  end

  test "calulates input fuels correctly" do
    masses = "fixtures/day01_fixture.txt"
      |> File.read!
      |> split_lines
      |> Enum.map(&String.to_integer/1)

    assert masses |> Day01.fuel_sum == 3327415
  end
end
