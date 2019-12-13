defmodule Day07 do
  def amplify(memory, input, [phase|[]]) do
    run(memory, [phase, input])
  end

  def amplify(memory, input, [phase|t]) do
    output = run(memory, [phase, input])

    amplify(memory, output, t)
  end

  defp run(memory, inputs) do
    memory
    |> Vm.run_intcode(inputs)
    |> Map.get(:output)
  end
end
