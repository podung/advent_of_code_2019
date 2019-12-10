defmodule Day06 do
  def count_orbits(orbits) do
    orbits
    |> Enum.map(fn orbit -> String.split(orbit, ")") end)
    |> Enum.reduce(%{}, fn [ orbitee, orbiter ], acc  ->

        Map.update(acc, orbitee, [ orbiter ], &( [orbiter | &1 ] ))
    end)
    |> count("COM", 0)
  end

  defp count(map, planet, acc) do
    orbiters = Map.get(map, planet, [])

    next = orbiters
           |> Enum.map(&(count(map, &1, acc + 1)))
           |> Enum.sum

    acc + next
  end
end
