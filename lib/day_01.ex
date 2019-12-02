defmodule Day01 do
  def fuel(mass) do
    div(mass,3) - 2
  end

  def fuel_sum(masses) do
    masses |> Enum.map(&fuel/1) |> Enum.sum
  end
end
