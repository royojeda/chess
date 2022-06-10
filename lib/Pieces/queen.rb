require './lib/Pieces/piece'

class Queen < Piece
  def moves
    upward_moves = []
    downward_moves = []
    leftward_moves = []
    rightward_moves = []
    up_right_moves = []
    up_left_moves = []
    down_right_moves = []
    down_left_moves = []
    (1..7).each do |i|
      upward_moves << [0, i]
      downward_moves << [0, -i]
      leftward_moves << [-i, 0]
      rightward_moves << [i, 0]
      up_right_moves << [i, i]
      up_left_moves << [-i, i]
      down_right_moves << [i, -i]
      down_left_moves << [-i, -i]
    end
    [upward_moves, downward_moves, leftward_moves, rightward_moves,
     up_right_moves, up_left_moves, down_right_moves, down_left_moves]
  end

  def to_s
    case color
    when 'white'
      color_white
    when 'black'
      color_black
    end
  end

  def color_white
    "\u2655"
  end

  def color_black
    "\u265B"
  end
end
