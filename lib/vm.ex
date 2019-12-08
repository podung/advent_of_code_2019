defmodule Vm do
  #@add_instruction 1
  #@multiply_instruction 2
  #@input_instruction 3
  #@output_instruction 4
  #@exit_instruction 99

  def run_intcode(intcode, input \\ nil) do
    run(VmData.new(intcode, input))
  end

  defp read(%VmData{ memory: memory }, index), do: Enum.at(memory, index)
  defp write(%VmData{ memory: memory } = data, index, value), do: Map.put(data, :memory, List.replace_at(memory, index, value))

  defp run(%VmData{ remaining: [3, index1 | _t], input: input} = data) do
    data = data
           |> write(index1, input)
           |> advance(2)

    run(data)
  end

  defp run(%VmData{ remaining: [4, index1 | _t] } = data) do
    data = data
           |> Map.put(:output, read(data, index1))
           |> advance(2)

    run(data)
  end

  defp run(%VmData{ remaining: [1, index1, index2, index3 | _t]} = data) do
    data = data
           |> write(index3, read(data, index1) +  read(data, index2))
           |> advance(4)

    run(data)
  end

  defp run(%VmData{ remaining: [2, index1, index2, index3 | _t]} = data) do
    data = data
           |> write(index3, read(data, index1) * read(data, index2))
           |> advance(4)

    run(data)
  end

  defp run(%VmData{ remaining: [99 | _t] } = data), do: data


  defp advance(%VmData{ cursor: cursor, memory: memory } = data, amount) do
    cursor = cursor + amount

    data
    |> Map.put(:cursor, cursor)
    |> Map.put(:remaining, Enum.slice(memory, cursor..-1))
  end
end
