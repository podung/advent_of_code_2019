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

  defp contains_a_double([], { data, double_count }) when length(data) == 2, do: true
  defp contains_a_double([], { _data, double_count }), do: double_count > 0

  defp contains_a_double([h|t], acc), do: contains_a_double(t, process(h, acc))

  defp process(digit, { [h | _t] = data, double_count }) when h == digit do
    { [digit | data], double_count }
  end

  defp process(digit, { [h | _t] = data, double_count }) when h != digit and length(data) == 2 do
    { [digit], double_count + 1 }
  end

  defp process(digit, { _data, double_count }) do
    { [digit], double_count }
  end
end
