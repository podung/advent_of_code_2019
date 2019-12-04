defmodule Day03Test do
  use ExUnit.Case

  import Aoc2019Utils

  test "calculates sample closest distance correctly" do
    assert Day03.distance_to_closest_intersection(
      "R8,U5,L5,D3",
      "U7,R6,D4,L4") == 6

    assert Day03.distance_to_closest_intersection(
      "R75,D30,R83,U83,L12,D49,R71,U7,L72",
      "U62,R66,U55,R34,D71,R55,D58,R83") == 159


    assert Day03.distance_to_closest_intersection(
      "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
      "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7") == 135
  end

  test "calculates input data closest distance correctly" do
    [wire1, wire2] = "fixtures/day03_fixture.txt"
      |> File.read!
      |> split_lines

    assert Day03.distance_to_closest_intersection(wire1, wire2) == 227
  end
end
