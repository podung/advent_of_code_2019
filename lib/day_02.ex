defmodule Day02 do
  def run_intcode(intcode) do
    run_intcode(Enum.slice(intcode, 0, 4), { 4, intcode })
  end

  defp operate(noun_index, verb_index, store_index, instruction, memory) do
    noun = memory |> Enum.at(noun_index)
    verb = memory |> Enum.at(verb_index)

    new_value = instruction.(noun, verb)

    memory |> List.replace_at(store_index, new_value)
  end

  defp run_intcode([1, index1, index2, index3], { cursor, acc }) do
    new_memory = operate(index1, index2, index3, &(&1 + &2), acc)
    next_instruction = new_memory |> Enum.slice(cursor, 4)

    run_intcode(next_instruction, { cursor + 4, new_memory })
  end

  defp run_intcode([2, index1, index2, index3], { cursor, acc }) do
    new_memory = operate(index1, index2, index3, &(&1 * &2), acc)
    next_instruction = new_memory |> Enum.slice(cursor, 4)

    run_intcode(next_instruction, { cursor + 4, new_memory })
  end

  defp run_intcode([99 | _t], { _cursor, acc }), do: acc


  ### Part 2 finder
  def find_input_values_for_output(memory, desired_output) do
    possibilities = for n <- 0..99, v <- 0..99, do: {n, v}

    input_values  = possibilities
      |> Enum.reduce_while(nil, fn { n, v }, acc ->
           memory = memory |> List.replace_at(1,n)
           memory = memory |> List.replace_at(2,v)

           output = Day02.run_intcode(memory) |> List.first

        if output == desired_output do
          { :halt, { n, v } }
        else
          { :cont, acc }
        end
     end)
  end
end
