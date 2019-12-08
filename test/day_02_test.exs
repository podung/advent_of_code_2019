defmodule Day02Test do
  use ExUnit.Case

  defp run(intcode) do
    intcode
    |> Day02.run_intcode
    |> Map.get(:memory)
  end

  test "calculates sample intcodes correctly" do

    assert run([1,0,0,0,99]) == [2,0,0,0,99]
    assert run([2,3,0,3,99]) == [2,3,0,6,99]
    assert run([2,4,4,5,99,0]) == [2,4,4,5,99,9801]
    assert run([1,1,1,4,99,5,6,0,99]) == [30,1,1,4,2,5,6,0,99]
  end

  test "calculates input intcodes correctly" do
    intcode = "fixtures/day02_fixture.txt"
      |> File.read!
      |> Aoc2019Utils.parse_ints

    intcode = intcode |> List.replace_at(1,12)
    intcode = intcode |> List.replace_at(2,2)

    assert run(intcode) |> List.first == 3267740
  end

  test "finds the correct input noun and verb within range" do
    intcode = "fixtures/day02_fixture.txt"
      |> File.read!
      |> Aoc2019Utils.parse_ints

    { noun, verb } =  Day02.find_input_values_for_output(intcode, 19690720)

    assert noun * 100 + verb == 7870
  end
end
