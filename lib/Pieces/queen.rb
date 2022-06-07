class Queen
  attr_reader :color

  def initialize(color:)
    @color = color
  end

  def moves
    arr = []
    (-7..7).each do |i|
      arr << [0, i]
      arr << [i, 0]
      arr << [i, i]
      arr << [-i, i]
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
    "\u2655"
  end

  def color_black
    "\u265B"
  end
end
