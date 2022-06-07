class King
  attr_reader :color

  def initialize(color:)
    @color = color
  end

  def moves
    upward_moves = [[0, 1]]
    downward_moves = [[0, -1]]
    leftward_moves = [[-1, 0]]
    rightward_moves = [[1, 0]]
    up_right_moves = [[1, 1]]
    up_left_moves = [[-1, 1]]
    down_right_moves = [[1, -1]]
    down_left_moves = [[-1, -1]]

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
    "\u2654"
  end

  def color_black
    "\u265A"
  end
end
