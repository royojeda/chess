class Knight
  attr_reader :color

  def initialize(color:)
    @color = color
  end

  def moves
    [[[1, 2]], [[2, 1]], [[2, -1]], [[1, -2]], [[-1, -2]], [[-2, -1]], [[-2, 1]], [[-1, 2]]]
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
    "\u2658"
  end

  def color_black
    "\u265E"
  end
end
