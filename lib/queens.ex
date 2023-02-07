defmodule Queens do
  @moduledoc """
  Represent a queen is Chess board.
  """

  @type position :: {non_neg_integer, non_neg_integer}

  @doc """
  Checks if the queens can attack each other or if white and black positions can attack the list of other pieces positions.
  The queens is able to attack each other when are in the same row, column or in diagonal.

      ## Examples
      iex> can_attack?({3, 2}, {6, 5})
      true
      iex> can_attack?({3, 3}, {6, 5})
      false
      iex> can_attack?({1, 1}, {2, 2}, [{3, 3}])
      true
  """
  @spec can_attack?(white_position :: position(), black_position :: position(), other_pieces :: list()) :: boolean()
  def can_attack?(
        white_position,
        black_position,
        other_pieces \\ nil
      ) do
    case other_pieces do
      nil ->
        do_can_attack?(white_position, black_position)

      other_pieces_list ->
        Enum.reduce_while(other_pieces_list, true, fn other_pieces_position, acc ->
          if do_can_attack?(white_position, other_pieces_position) and
               do_can_attack?(black_position, other_pieces_position) do
            {:halt, false}
          else
            {:cont, true}
          end
        end)
    end
  end

  defp

  defp do_can_attack?(
         {white_position_x, white_position_y} = white_position,
         {black_position_x, black_position_y} = black_position
       ) do
    is_the_same_row?(white_position_x, black_position_x) or
      is_the_same_row?(white_position_y, black_position_y) or
      is_diagonal?(white_position, black_position)
  end

  defp is_the_same_row?(pos_x, pos_y), do: pos_x == pos_y

  defp is_diagonal?({white_position_x, white_position_y}, {black_position_x, black_position_y}),
    do: abs(black_position_x - white_position_x) == abs(black_position_y - white_position_y)
end
