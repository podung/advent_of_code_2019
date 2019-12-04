defmodule Day03 do
  def distance_to_closest_intersection(first,second) do

    first_points = parse_wire(first)
    second_points = parse_wire(second)

    first_points
    |> MapSet.intersection(second_points)
    |> MapSet.delete({0,0})
    |> Enum.map(&calculate_manhatten_distance/1)
    |> Enum.min
  end

  defp parse_wire(wire) do
    wire
    |> String.split(",")
    |> Enum.map(&parse_directions/1)
    |> Enum.reduce([{0,0}], fn section, acc ->
      acc ++ plot_points(section, acc |> List.last)
    end)
    |> MapSet.new
  end

  defp parse_directions(<< dir :: utf8, length :: bitstring>>),
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

  defp calculate_manhatten_distance({ x, y }), do: abs(x) + abs(y)
end
