defmodule Day06Test do
  use ExUnit.Case

  test "it counts sample data orbits correctly" do
    data = """
    COM)B
    B)C
    C)D
    D)E
    E)F
    B)G
    G)H
    D)I
    E)J
    J)K
    K)L
    """ |> String.split("\n", trim: true)

    assert Day06.count_orbits(data) == 42
  end

  test "it handles counts test input properly" do
    input = "fixtures/day06_fixture.txt"
            |> File.read!
            |> Aoc2019Utils.split_lines

    assert Day06.count_orbits(input) == 247089
  end

  test "it calculates orbital transfer between planets" do
    data = """
    COM)B
    B)C
    C)D
    D)E
    E)F
    B)G
    G)H
    D)I
    E)J
    J)K
    K)L
    K)YOU
    I)SAN
    """ |> String.split("\n", trim: true)

    assert Day06.transfers_between(data, "YOU", "SAN") == 4
  end

  test "it calcs orbital transfers in actual input properly" do
    input = "fixtures/day06_fixture.txt"
            |> File.read!
            |> Aoc2019Utils.split_lines

    assert Day06.transfers_between(input, "YOU", "SAN") == 442
  end
end
