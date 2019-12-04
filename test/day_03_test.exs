defmodule Day03Test do
  use ExUnit.Case

  test "calculates sample closest distance correctly" do
    assert Day03.distance_to_closest_intersection("R8,U5,L5,D3","U7,R6,D4,L4") == 156
    #assert Day03.distance_to_closest_intersection("R8,U5,L5,D3","U7,R6,D4,L4") |> Enum.count == 5
  end
end
