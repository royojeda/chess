class Rook
  attr_reader :color

  def initialize(color:)
    @color = color
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
    "\u2656"
  end

  def color_black
    "\u265C"
  end
end
