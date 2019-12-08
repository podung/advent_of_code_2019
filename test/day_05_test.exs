defmodule Day05Test do
  use ExUnit.Case

  test "handles inputs and outputs" do
    test_value = 458

    %VmData{ output: output } = Vm.run_intcode([3,0,4,0,99], test_value)

    assert output == test_value
  end
end
