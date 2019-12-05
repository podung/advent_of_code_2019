defmodule Day04Test do
  use ExUnit.Case

  test "calculates possible passwords correctly" do
    assert Day04.count_part1(284639,748759) == 895
  end

  test "calculates part 2 possible passwords correctly" do
    assert Day04.count_part2(284639,748759) == 895
  end
end
