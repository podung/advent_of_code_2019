defmodule Day04 do
  def count_part1(starting,ending) do
    (starting..ending)
    |> Enum.map(&Integer.digits/1)
    |> Enum.count(&(all_asc(&1) && contains_dups(&1)))
  end

  def count_part2(starting,ending) do
    (starting..ending)
    |> Enum.map(&Integer.digits/1)
    |> Enum.count(&(all_asc(&1) && contains_a_double(&1)))
  end


  defp all_asc(password), do: password == Enum.sort(password)
  defp contains_dups(password), do: password != Enum.dedup(password)

  defp contains_a_double(password), do: contains_a_double(password, {[], 0 })

  defp contains_a_double([], { _acc, double_count }), do: double_count

  defp contains_a_double([h|t], { acc, double_count }) do
    if List.last(acc) == h do
      contains_a_double(t, { [ h | acc], double_count })
    else if Enum.count(acc) == 2 do
      contains_a_double(t, { [h], double_count + 1 })
    else
      contains_a_double(t, { [h], double_count })
    end
  end
end
