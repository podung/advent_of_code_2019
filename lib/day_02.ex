defmodule Day02 do
  def run_intcode(intcode) do
    run_intcode(Enum.slice(intcode, 0, 4), { 4, intcode })
  end

  defp run_intcode([1, index1, index2, index3], { cursor, acc }) do
    addend1 = acc |> Enum.at(index1)
    addend2 = acc |> Enum.at(index2)

    acc = acc |> List.replace_at(index3, addend1 + addend2)

    next = acc |> Enum.slice(cursor, 4)

    run_intcode(next, { cursor + 4, acc })
  end

  defp run_intcode([2, index1, index2, index3], { cursor, acc }) do
    factor1 = acc |> Enum.at(index1)
    factor2 = acc |> Enum.at(index2)

    acc = acc |> List.replace_at(index3, factor1 * factor2)

    next = acc |> Enum.slice(cursor, 4)

    run_intcode(next, { cursor + 4, acc })
  end

  defp run_intcode([99 | t], { cursor, acc }), do: acc

end
