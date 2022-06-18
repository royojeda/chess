require './lib/Pieces/piece'
require './lib/Modules/movable'

class Pawn < Piece
  include Movable

  def moves
    first_move ? two_forward : one_forward
  end

  def specials
    captures
  end

  def special_allowed?(special, board)
    board.enemy_piece_at?(color, destination_from(special)) ||
      board.allows_en_passant_by?(self, special[0])
  end

  def stop_before?(board, destination)
    board.out_of_bounds?(destination) || !board.square_at(destination).empty?
  end

  def stop_after?(_board, _destination)
    false
  end

  private

  def captures
    front_left + front_right
  end

  def one_forward
    color == 'white' ? [upward_moves(1)] : [downward_moves(1)]
  end

  def two_forward
    color == 'white' ? [upward_moves(2)] : [downward_moves(2)]
  end

  def front_left
    color == 'white' ? up_left_moves(1) : down_right_moves(1)
  end

  def front_right
    color == 'white' ? up_right_moves(1) : down_left_moves(1)
  end

  def color_white
    "\u2659"
  end

  def color_black
    "\u265F"
  end
end
