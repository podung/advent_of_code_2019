defmodule Day02 do
  def init_and_run([3, input_register | _t] = memory, input_value) do
    memory
    |> write(input_register, input_value)
    |> run_intcode
  end

  def run_intcode(intcode) do
    run({ 0, intcode, intcode })
  end

  defp read({ _cursor, _remaining, memory }, index), do: Enum.at(memory, index)
  defp write({ cursor, remaining, memory }, index, value), do: { cursor, remaining, List.replace_at(memory, index, value) }

  defp run({ _cursor, [1, index1, index2, index3 | _t], _memory } = data) do
    data = data
           |> write(index3, read(data, index1) +  read(data, index2))
           |> advance(4)

    run(data)
  end

  defp run({ _cursor, [2, index1, index2, index3 | _t], _memory } = data) do
    data = data
           |> write(index3, read(data, index1) * read(data, index2))
           |> advance(4)

    run(data)
  end

  defp run({ _cursor, [99 | _t], _memory } = data), do: data


  defp advance({ cursor, _remaining, memory }, amount) do
    cursor = cursor + amount

    { cursor, Enum.slice(memory, cursor..-1), memory }
  end



  ### Part 2 finder
  def find_input_values_for_output(memory, desired_output) do
    possibilities = for n <- 0..99, v <- 0..99, do: {n, v}

    possibilities
      |> Enum.reduce_while(nil, fn { n, v }, acc ->
           memory = memory |> List.replace_at(1,n)
           memory = memory |> List.replace_at(2,v)

           output = elem(Day02.run_intcode(memory), 2) |> List.first

        if output == desired_output do
          { :halt, { n, v } }
        else
          { :cont, acc }
        end
     end)
  end
end
