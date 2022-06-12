require './lib/Pieces/piece'

class Rook < Piece
  def post_initialize
    @first_move = true
  end

  def moves
    upward_moves = []
    downward_moves = []
    leftward_moves = []
    rightward_moves = []
    (1..7).each do |i|
      upward_moves << [0, i]
      downward_moves << [0, -i]
      leftward_moves << [-i, 0]
      rightward_moves << [i, 0]
    end
    [upward_moves, downward_moves, leftward_moves, rightward_moves]
  end

  def color_white
    "\u2656"
  end

  def color_black
    "\u265C"
  end
end
