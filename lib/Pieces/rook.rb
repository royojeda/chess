class Rook
  attr_reader :color

  def initialize(color:)
    @color = color
  end

  def moves
    arr = []
    (-7..7).each do |i|
      arr << [0, i]
      arr << [i, 0]
    end
    arr
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
