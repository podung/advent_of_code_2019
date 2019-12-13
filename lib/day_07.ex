defmodule Day07 do
  def permutations([]), do: [[]]
  def permutations(list) do
    for head <- list, tail <- permutations(list -- [head]), do: [head|tail]
  end

  def optimized_amplification(memory) do
    [0,1,2,3,4]
    |> permutations
    |> Enum.map(&amplify(memory, 0, &1))
    |> Enum.max
  end

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
