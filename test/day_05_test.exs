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

  test "handles jumps in position mode" do
    intcode = [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]
    non_zero = 42

    assert Day05.get_output(intcode, non_zero) == 1
    assert Day05.get_output(intcode, 0) == 0
  end

  test "handles jumps in immediate mode" do
    intcode = [3,3,1105,-1,9,1101,0,0,12,4,12,99,1]
    non_zero = 42

    assert Day05.get_output(intcode, non_zero) == 1
    assert Day05.get_output(intcode, 0) == 0
  end

  test "handles jumps - bigger example" do
    intcode = [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
               1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
               999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99]

    assert Day05.get_output(intcode, -14) == 999
    assert Day05.get_output(intcode, 0) == 999
    assert Day05.get_output(intcode, 2) == 999
    assert Day05.get_output(intcode, 7) == 999
    assert Day05.get_output(intcode, 8) == 1000
    assert Day05.get_output(intcode, 9) == 1001
    assert Day05.get_output(intcode, 999) == 1001
  end

  test "gets correct output for input program with init value of 5" do
    intcode = "fixtures/day05_fixture.txt"
      |> File.read!
      |> Aoc2019Utils.parse_ints

    assert Day05.get_output(intcode, 5) == 742621
  end
end
