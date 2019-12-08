defmodule Vm do
  def init_and_run([3, input_register | _t] = memory, input_value) do
    memory
    |> write(input_register, input_value)
    |> run_intcode
  end

  def run_intcode(intcode) do
    run(VmData.new(intcode))
  end

  defp read(%VmData{ memory: memory }, index), do: Enum.at(memory, index)
  defp write(%VmData{ memory: memory } = data, index, value), do: Map.put(data, :memory, List.replace_at(memory, index, value))

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
