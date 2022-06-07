class King
  attr_reader :color

  def initialize(color:)
    @color = color
  end

  def moves
    [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
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
