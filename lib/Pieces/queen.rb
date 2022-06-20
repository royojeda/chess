require './lib/Pieces/piece'
require './lib/Modules/movable'

class Queen < Piece
  include Movable

  def moves
    [upward_moves, downward_moves, leftward_moves, rightward_moves,
     up_right_moves, up_left_moves, down_right_moves, down_left_moves]
  end

  private

  def color_white
    "\u2655"
  end

  def color_black
    "\u265B"
  end
end
