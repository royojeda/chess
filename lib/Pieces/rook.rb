require './lib/Pieces/piece'
require './lib/Modules/movable'

class Rook < Piece
  include Movable

  def moves
    [upward_moves, downward_moves, leftward_moves, rightward_moves]
  end

  private

  def color_white
    "\u2656"
  end

  def color_black
    "\u265C"
  end
end
