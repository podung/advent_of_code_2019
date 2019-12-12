defmodule Day06 do
  # COM)B
  # B)C
  # B)D
  # D)E
  # C)F
  #
  #
  # orbits %{}
  # orbiter -> planet
  # -----------------
  # B -> COM
  # C -> B
  # D -> B
  # E -> D
  # F -> C
  #
  # acc
  # B -> [COM]
  # C -> [B, COM]
  # E -> [D, B, COM]
  # D -> [B, COM]
  # F -> [C, B, COM]
  #
  def count_orbits(orbits) do
    orbits
    |> paths_to_com
    |> Map.values
    |> List.flatten
    |> Enum.count
  end

  defp paths_to_com(orbits) do
    lookup = orbits
             |> Enum.map(fn orbit -> String.split(orbit, ")") end)
             |> Map.new(fn [planet, orbiter] -> { orbiter, planet } end)

    lookup
    |> Map.keys
    |> Enum.reduce(%{}, fn planet, acc ->
      full_path = path_to_com(lookup, planet, [])
      Map.put(acc, planet, full_path)
    end)
  end

  defp path_to_com(lookup, "COM", path), do: Enum.reverse(path)
  defp path_to_com(lookup, planet, path) do
    next_planet = Map.get(lookup, planet)

    path_to_com(lookup, next_planet, [ next_planet | path ])
  end
end
