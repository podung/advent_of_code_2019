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

  def transfers_between(orbits, planet_1, planet_2) do
    paths = paths_to_com(orbits)

    planet_1_path = Map.get(paths, planet_1)
    planet_2_path = Map.get(paths, planet_2)

    planet_1_path
    |> Enum.with_index
    |> Enum.reduce_while(nil, fn { p1, p1_index }, acc ->
          p2_index = Enum.find_index(planet_2_path, fn p2 -> p1 == p2 end)

          case p2_index do
            nil -> { :cont, acc }
            _ -> { :halt, p1_index + p2_index }
          end
       end)
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

  defp path_to_com(_lookup, "COM", path), do: Enum.reverse(path)
  defp path_to_com(lookup, planet, path) do
    next_planet = Map.get(lookup, planet)

    path_to_com(lookup, next_planet, [ next_planet | path ])
  end
end
