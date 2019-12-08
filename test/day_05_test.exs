defmodule Day05Test do
  use ExUnit.Case

  test "handles inputs and outputs" do
    test_value = 458

    assert Day05.get_output([3,0,4,0,99], test_value) == test_value
  end
end
