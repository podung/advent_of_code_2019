defmodule Day02 do
  def run_intcode(intcode) do
    Vm.run_intcode(intcode)
  end

  ## Part 2 finder
  def find_input_values_for_output(memory, desired_output) do
    possibilities = for n <- 0..99, v <- 0..99, do: {n, v}

    possibilities
      |> Enum.reduce_while(nil, fn { n, v }, acc ->
           memory = memory |> List.replace_at(1,n)
           memory = memory |> List.replace_at(2,v)

           output = memory
                    |> Vm.run_intcode
                    |> Map.get(:memory)
                    |> List.first

        if output == desired_output do
          { :halt, { n, v } }
        else
          { :cont, acc }
        end
     end)
  end
end
