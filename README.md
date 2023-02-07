# Introduction

Given the position of two queens on a chess board, indicate whether or not they are positioned so that they can attack each other.

In the game of chess, a queen can attack pieces which are on the same row, column, or diagonal.

A chessboard can be represented by an 8 by 8 matrix.

So if you receive the following arguments:
- white queen at (3, 2)
- black queen at (6, 5)

Your setup is:

```
  0 1 2 3 4 5 6 7
0 _ _ _ _ _ _ _ _
1 _ _ _ _ _ _ _ _
2 _ _ _ W _ _ _ B
3 _ _ _ _ _ _ _ _
4 _ _ _ _ _ _ _ _
5 _ _ _ _ _ _ B _
6 _ _ _ _ _ _ _ _
7 _ _ _ _ _ _ _ _
```

In this case, the two queens can attack each other, because they share a diagonal.

```
  0 1 2 3 4 5 6 7
0 _ _ _ _ _ _ _ _
1 _ _ _ _ _ _ _ _
2 _ _ _ W _ _ _ _
3 _ _ _ _ X _ _ _
4 _ _ _ _ _ X _ _
5 _ _ _ _ _ _ B _
6 _ _ _ _ _ _ _ _
7 _ _ _ _ _ _ _ _
```


## Starting code

```
# queens/lib/queens.ex
defmodule Queens do
  @type position :: {non_neg_integer, non_neg_integer}

  @doc """
  Checks if the queens can attack each other.
  """
  @spec can_attack?(white_position :: position(), black_position :: position()) :: boolean()
  def can_attack?(white_position, black_position) do
    # TODO implement can_attack?/2 or any other function you may need
  end
end
```

```
# queens/test/queens_test.exs
ExUnit.start()

defmodule QueensTest do
  use ExUnit.Case
  
  test "{3, 2}, {6, 5}" do
    assert Queens.can_attack?({3, 2}, {6, 5})
  end
  
  test "{3, 3}, {6, 5}" do
    refute Queens.can_attack?({3, 3}, {6, 5})
  end
  
  # feel free to write more
end
```

## Problem 1
Write the code to receive the position of a white queen and a black queen. Then check whether two queens can attack each other. It should return `true` if they can, or `false` if they cannot.



## Problem 2
Building on top of the previous code, now we can receive the position of the two queens and a list of `other_pieces`. 
Then check whether two queens can attack each other, considering that one of the `other_pieces` 
could be in the line of attack. It should return `true` if they can, or `false` if they cannot.

## Problem 3 (extra)
Building on top of the previous code, now we need to receive the positions of the two queens, `other_pieces`, and two kings (one black and one white). Then check whether two queens can attack each other.
If they can, check if the defensive opponent ends up in check - this means the king is threatened by the opposing queen.

It should return:
- `"white_in_check"` if white end up in check after losing its queen to black;
- `"black_in_check"` if black end up in check after losing its queen to white;
- `"none"` if the queens can attack each other, but none of them ends up in check after losing their queens;
- or `false` if their queens cannot attack each other.