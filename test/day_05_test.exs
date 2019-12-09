defmodule Day05Test do
  use ExUnit.Case

  test "handles inputs and outputs" do
    test_value = 458

    assert Day05.get_output([3,0,4,0,99], test_value) == test_value
  end

  test "handles simple modes properly" do
    result = [1002,4,3,4,33]
             |> Vm.run_intcode
             |> Map.get(:memory)

    assert result == [1002,4,3,4,99]
  end

  test "gets correct output for input program with init value of 1" do
    intcode = "fixtures/day05_fixture.txt"
      |> File.read!
      |> Aoc2019Utils.parse_ints

    assert Day05.get_output(intcode, 1) == 9961446
  end
end
