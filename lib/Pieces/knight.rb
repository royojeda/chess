require './lib/Pieces/piece'

class Knight < Piece
  def moves
    [[nne], [ene], [ese], [sse], [ssw], [wsw], [wnw], [nnw]]
  end

  private

  def nne
    [1, 2]
  end

  def ene
    [2, 1]
  end

  def ese
    [2, -1]
  end

  def sse
    [1, -2]
  end

  def ssw
    [-1, -2]
  end

  def wsw
    [-2, -1]
  end

  def wnw
    [-2, 1]
  end

  def nnw
    [-1, 2]
  end

  def color_white
    "\u2658"
  end

  def color_black
    "\u265E"
  end
end
