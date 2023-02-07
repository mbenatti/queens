defmodule Queens do
  @moduledoc """
  Represent a chess board game logic following the challenge described on README.md.
  """

  @type position :: {non_neg_integer, non_neg_integer}

  @type other_pieces :: [{non_neg_integer, non_neg_integer}]

  @doc """
  Checks if the queens can attack each other or if white and black positions can attack the list of other pieces positions.
  The queens is able to attack each other when are in the same row, column or in diagonal.
  if the third argument is passed it check whether two queens can attack each other, considering that one of the `other_pieces`
  could be in the line of attack.

      ## Examples
      iex> can_attack?({3, 2}, {6, 5})
      true
      iex> can_attack?({3, 3}, {6, 5})
      false
      iex> can_attack?({1, 1}, {2, 2}, [{3, 3}])
      true
  """
  @spec can_attack?(
          white_position :: position(),
          black_position :: position(),
          other_pieces :: other_pieces()
        ) :: boolean()
  def can_attack?(
        {white_position_x, white_position_y} = white_position,
        {black_position_x, black_position_y} = black_position,
        other_pieces \\ nil
      ) do
    case other_pieces do
      nil ->
        do_can_attack?(white_position, black_position)

      other_pieces_list ->
        Enum.reduce_while(other_pieces_list, false, fn {other_pieces_position_x,
                                                        other_pieces_position_y} =
                                                         other_pieces_position,
                                                       _ ->
          with {:halt, false} <-
                 # X or row positions
                 {
                   :halt,
                   # verify if white and black position are in the same line
                   is_the_same_row_or_column?(white_position_x, black_position_x) and
                     # verify if white position are in the same line as other pieces,
                     # this mean black is in the same line as well(because we checked above)
                     is_the_same_row_or_column?(white_position_x, other_pieces_position_x) and
                     is_not_in_the_middle?(
                       black_position_y,
                       white_position_y,
                       other_pieces_position_y
                     )
                 },
               # Y or column positions
               {:halt, false} <-
                 {:halt,
                  is_the_same_row_or_column?(white_position_y, black_position_y) and
                    is_the_same_row_or_column?(white_position_y, other_pieces_position_y) and
                    is_not_in_the_middle?(
                      black_position_x,
                      white_position_x,
                      other_pieces_position_x
                    )},
               # diagonal positions
               {:halt, false} <-
                 {:halt,
                  is_diagonal?(white_position, black_position) and
                    is_diagonal?(white_position, other_pieces_position) and
                    is_not_in_the_middle?(black_position, white_position, other_pieces_position)} do
            {:cont, false}
          else
            _ -> {:halt, true}
          end
        end)
    end
  end

  defp do_can_attack?(
         {white_position_x, white_position_y} = white_position,
         {black_position_x, black_position_y} = black_position
       ) do
    is_the_same_row_or_column?(white_position_x, black_position_x) or
      is_the_same_row_or_column?(white_position_y, black_position_y) or
      is_diagonal?(white_position, black_position)
  end

  defp is_the_same_row_or_column?(pos_x, pos_y), do: pos_x == pos_y

  defp is_diagonal?({white_position_x, white_position_y}, {black_position_x, black_position_y}),
    do: abs(black_position_x - white_position_x) == abs(black_position_y - white_position_y)

  defp is_not_in_the_middle?(
         {white_position_x, white_position_y},
         {black_position_x, black_position_y},
         {other_position_x, other_position_y}
       ) do
    pos_x = white_position_x + white_position_y
    pos_y = black_position_x + black_position_y
    other_diagonal_pos = other_position_x + other_position_y

    is_not_in_the_middle?(pos_x, pos_y, other_diagonal_pos)
  end

  defp is_not_in_the_middle?(white_position_number, black_position_number, other_position_number) do
    if white_position_number != black_position_number,
      do:
        not Enum.member?(white_position_number..black_position_number, other_position_number) and
          not Enum.member?(black_position_number..white_position_number, other_position_number),
      else: false
  end
end
