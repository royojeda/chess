require './lib/Pieces/piece'
require './lib/Modules/movable'

class Bishop < Piece
  include Movable

  def moves
    [up_right_moves, up_left_moves, down_right_moves, down_left_moves]
  end

  def color_white
    "\u2657"
  end

  def color_black
    "\u265D"
  end
end
