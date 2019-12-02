defmodule Day01 do
  def fuel(mass) do
    max(div(mass,3) - 2, 0)
  end

  def fuel_sum(masses) do
    masses |> Enum.map(&fuel/1) |> Enum.sum
  end

  def fuel_inclusive(mass, total) when mass <= 0, do: total

  def fuel_inclusive(mass, total) do
    fuel_mass = mass |> fuel

    fuel_inclusive(fuel_mass, total + fuel_mass)
  end

  def fuel_inclusive(mass), do: fuel_inclusive(mass, 0)

  def fuel_inclusive_sum(masses) do
    masses
    |> Enum.map(&fuel_inclusive/1)
    |> Enum.sum
  end
end
