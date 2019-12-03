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

end
