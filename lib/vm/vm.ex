defmodule Vm do
  #@add_instruction 1
  #@multiply_instruction 2
  #@input_instruction 3
  #@output_instruction 4
  #@exit_instruction 99

  def run_intcode(intcode, input \\ nil) do
    intcode
    |> VmData.new(input)
    |> advance
    |> run
  end

  defp read(%VmData{ memory: memory }, index) do
    Enum.at(memory, index)
  end
  defp write(%VmData{ memory: memory } = data, register, value) do
    data |> Map.put(:memory,
              List.replace_at(memory, register, value))
  end

  defp param(%VmData{ params: params } = data, index) do
    param = params |> Enum.at(index)

    if param.mode == :position, do: read(data, param.value), else: param.value
  end

  defp run(%VmData{ command: :init_input, input: input } = data) do
    register = data.params |> List.first |> Map.get(:value)

    data
    |> write(register, input)
    |> advance
    |> run
  end

  defp run(%VmData{ command: :record_output } = data) do
    output = param(data, 0)

    data
    |> Map.put(:output, output)
    |> advance
    |> run
  end

  defp run(%VmData{ command: :add,  } = data) do
    param1 = param(data, 0)
    param2 = param(data, 1)
    param3 = data.params |> Enum.at(2) |> Map.get(:value)

    data
    |> write(param3, param1 + param2)
    |> advance
    |> run
  end

  defp run(%VmData{ command: :multiply } = data) do
    param1 = param(data, 0)
    param2 = param(data, 1)
    param3 = data.params |> Enum.at(2) |> Map.get(:value)

    data
    |> write(param3, param1 * param2)
    |> advance
    |> run
  end

  defp run(%VmData{ command: :less_than } = data) do
    param1 = param(data, 0)
    param2 = param(data, 1)
    param3 = data.params |> Enum.at(2) |> Map.get(:value)

    is_less_than = if param1 < param2, do: 1, else: 0

    data
    |> write(param3, is_less_than)
    |> advance
    |> run
  end

  defp run(%VmData{ command: :equal_to } = data) do
    param1 = param(data, 0)
    param2 = param(data, 1)
    param3 = data.params |> Enum.at(2) |> Map.get(:value)

    is_equal_to = if param1 == param2, do: 1, else: 0

    data
    |> write(param3, is_equal_to)
    |> advance
    |> run
  end

  defp run(%VmData{ command: :jump_if_true, cursor: cursor } = data) do
    param1 = param(data, 0)
    param2 = param(data, 1)
    cursor = if param1 != 0, do: param2, else: cursor

    data
    |> Map.put(:cursor, cursor)
    |> advance
    |> run
  end

  defp run(%VmData{ command: :jump_if_false, cursor: cursor } = data) do
    param1 = param(data, 0)
    param2 = param(data, 1)
    cursor = if param1 == 0, do: param2, else: cursor

    data
    |> Map.put(:cursor, cursor)
    |> advance
    |> run
  end

  defp run(%VmData{ command: :exit } = data), do: data

  defp advance(%VmData{} = data), do: VmData.parse_next(data)
end
