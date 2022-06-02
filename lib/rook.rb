class Rook
  attr_reader :color

  def initialize(color: 'white')
    @color = color
  end

  def to_s
    case color
    when 'white'
      "\u2656"
    when 'black'
      "\u265C"
    end
  end
end
