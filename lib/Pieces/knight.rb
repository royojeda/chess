require './lib/Pieces/piece'

class Knight < Piece
  def moves
    [[[1, 2]], [[2, 1]], [[2, -1]], [[1, -2]], [[-1, -2]], [[-2, -1]], [[-2, 1]], [[-1, 2]]]
  end

  def color_white
    "\u2658"
  end

  def color_black
    "\u265E"
  end
end
