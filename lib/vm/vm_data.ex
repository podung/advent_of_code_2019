defmodule VmData do
  defstruct cursor: 0,
            command: nil,
            params: [],
            memory: [],
            input: nil,
            output: nil

  def new(memory, input \\ nil) do
    %VmData{ memory: memory, input: input }
  end

  def parse_next(%VmData{ cursor: cursor, memory: memory }=data) do
    remaining = Enum.slice(memory, cursor..-1)

    { command, param_count } = parse_command(remaining)

    params = parse_params(remaining, param_count)

    data
    |> Map.put(:cursor, cursor + param_count + 1)
    |> Map.put(:command, command)
    |> Map.put(:params, params)
  end

  defp convert(1), do: { :add, 3 }
  defp convert(2), do: { :multiply, 3 }
  defp convert(3), do: { :init_input, 1 }
  defp convert(4), do: { :record_output, 1 }
  defp convert(99), do: { :exit, 0 }

  # TODO: comment this with explanation
  defp parse_command([code|_t]), do: convert(rem(code, 100))

  # TODO: comment this with explanation
  defp parse_params([code|rest], param_count) do
    modes = code
            |> div(100)
            |> Integer.digits
            |> Enum.reverse

    # TODO: I think there's a "bug" here
    #       0..-1 if there are 0 params, doesn't do the rigth thing
    #       This will never return 0 params, and will get 2 params
    #       when it should have 0

    for n <- 0..param_count-1 do
      case Enum.at(modes, n, 0) do
        0 -> %{ value: Enum.at(rest, n), mode: :position }
        1 -> %{ value: Enum.at(rest, n), mode: :immediate }
      end
    end
  end
end
