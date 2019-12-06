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

  defp contains_a_double(password) do
    password
    |> Enum.group_by(&(&1))
    |> Map.values
    |> Enum.any?(fn x -> Enum.count(x) == 2 end)
  end
end
