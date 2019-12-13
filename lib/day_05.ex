defmodule Day05 do
  def get_output(intcode, input) do
    intcode
    |> Vm.run_intcode([input])
    |> Map.get(:output)
  end
end
