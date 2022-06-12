require './lib/Pieces/piece'

class Bishop < Piece
  def moves
    up_right_moves = []
    up_left_moves = []
    down_right_moves = []
    down_left_moves = []
    (1..7).each do |i|
      up_right_moves << [i, i]
      up_left_moves << [-i, i]
      down_right_moves << [i, -i]
      down_left_moves << [-i, -i]
    end
    [up_right_moves, up_left_moves, down_right_moves, down_left_moves]
  end

  def color_white
    "\u2657"
  end

  def color_black
    "\u265D"
  end
end
