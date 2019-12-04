defmodule Day03 do
  def distance_to_closest_intersection(first,second) do

    parse_wire(first)
  end

  defp parse_wire(wire) do
    wire
    |> String.split(",")
    |> Enum.map(&parse_direction/1)
    |> Enum.reduce([{0,0}], fn section, acc ->
      acc ++ plot_points(section, acc |> List.last)
    end)
    |> Enum.map(&IO.inspect/1)
  end

  defp parse_direction(<< dir :: utf8, length :: bitstring>>),
    do: { List.to_string([dir]), String.to_integer(length) }

  defp plot_points({ "R", length }, { x, y }) do
    for x <- x+1..x+length, y <- [y], do: { x, y }
  end

  defp plot_points({ "L", length }, { x, y }) do
    for x <- x-1..x-length, y <- [y], do: { x, y }
  end

  defp plot_points({ "U", length }, { x, y }) do
    for x <- [x], y <- y+1..y+length, do: { x, y }
  end

  defp plot_points({ "D", length }, { x, y }) do
    for x <- [x], y <- y-1..y-length, do: { x, y }
  end
end
