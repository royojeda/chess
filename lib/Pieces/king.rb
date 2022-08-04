require './lib/Pieces/piece'
require './lib/Modules/movable'

class King < Piece
  include Movable

  def moves
    [upward_moves(range), downward_moves(range), leftward_moves(range), rightward_moves(range),
     up_right_moves(range), up_left_moves(range), down_right_moves(range), down_left_moves(range)]
  end

  def specials
    castles
  end

  def special_allowed?(special, board, for_check: false)
    return false if for_check

    move = destination_from(special)
    first_move &&
      !board.check?(color) &&
      board.all_empty?(locations_between_king_and_rook(move)) &&
      board.none_attacked?(color, locations_in_king_path(move)) &&
      board.can_castle?(color, rook_square(move))
  end

  private

  def range
    1
  end

  def right_side_castle?(move)
    move[0] == 'g'
  end

  def locations_in_king_path(move)
    if right_side_castle?(move)
      [first_right] + [second_right]
    else
      [first_left] + [second_left]
    end
  end

  def rook_square(move)
    if right_side_castle?(move)
      third_right
    else
      fourth_left
    end
  end

  def locations_between_king_and_rook(move)
    if right_side_castle?(move)
      locations_in_king_path(move)
    else
      locations_in_king_path(move) + [third_left]
    end
  end

  def first_right
    [(square.file.ord + 1).chr, square.rank]
  end

  def second_right
    [(square.file.ord + 2).chr, square.rank]
  end

  def third_right
    [(square.file.ord + 3).chr, square.rank]
  end

  def first_left
    [(square.file.ord - 1).chr, square.rank]
  end

  def second_left
    [(square.file.ord - 2).chr, square.rank]
  end

  def third_left
    [(square.file.ord - 3).chr, square.rank]
  end

  def fourth_left
    [(square.file.ord - 4).chr, square.rank]
  end

  def castles
    [[2, 0], [-2, 0]]
  end

  def color_white
    "\u2654"
  end

  def color_black
    "\u265A"
  end
end
