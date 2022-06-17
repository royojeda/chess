require './lib/Pieces/piece'
require './lib/Modules/movable'

class King < Piece
  include Movable

  def moves
    [upward_moves(range), downward_moves(range), leftward_moves(range), rightward_moves(range),
     up_right_moves(range), up_left_moves(range), down_right_moves(range), down_left_moves(range)]
  end

  def range
    1
  end

  def specials
    castles
  end

  def special_allowed?(special, board)
    destination = destination_from(special)
    if destination[0] > square.file
      locations_in_king_path = [first_right] + [second_right]
      locations_between_king_and_rook = locations_in_king_path
      rook_square = third_right
    else
      locations_in_king_path = [first_left] + [second_left]
      locations_between_king_and_rook = locations_in_king_path + [third_left]
      rook_square = fourth_left
    end
    !board.check?(color) && first_move &&
      locations_between_king_and_rook.all? do |location|
        board.empty_at?(location)
      end &&
      locations_in_king_path.none? do |location|
        board.attacked?(color, location)
      end &&
      board.can_castle?(color, rook_square)
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
