defmodule QueensTest do
  use ExUnit.Case

  describe "can_attack?/2" do
    test "if is on diagonal" do
      assert Queens.can_attack?({3, 2}, {6, 5})
    end

    test "if is in the same row" do
      assert Queens.can_attack?({3, 3}, {3, 5})
    end

    test "if is in the same column" do
      assert Queens.can_attack?({3, 5}, {6, 5})
    end

    test "if the positions are invalid" do
      refute Queens.can_attack?({3, 3}, {6, 5})
    end
  end

  describe "can_attack?/3" do
    test "if the other_pieces_positions on same row" do
      assert Queens.can_attack?({2, 1}, {2, 5}, [{2, 0}])
    end

    test "if the other_pieces_positions on same column" do
      assert Queens.can_attack?({1, 0}, {3, 0}, [{0, 0}])
    end

    test "if the other_pieces_positions on diagonal" do
      assert Queens.can_attack?({1, 1}, {3, 3}, [{4, 4}])
    end

    test "if the other_pieces_positions on same row but in the middle" do
      refute Queens.can_attack?({0, 1}, {0, 6}, [{0, 3}])
    end

    test "if the other_pieces_positions on same column but in the middle" do
      refute Queens.can_attack?({1, 0}, {3, 0}, [{2, 0}])
    end

    test "if the other_pieces_positions on diagonal but in the middle" do
      refute Queens.can_attack?({1, 1}, {3, 3}, [{2, 2}])
    end
  end
end
