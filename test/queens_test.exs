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
end
