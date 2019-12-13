defmodule Day07Test do
  use ExUnit.Case

  test "handles inputs and outputs" do
    memory = "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0"
             |> Aoc2019Utils.parse_ints

    assert Day07.amplify(memory, 0, [4,3,2,1,0]) == 43210
  end
end
