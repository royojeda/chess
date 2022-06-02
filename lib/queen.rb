class Queen
  attr_reader :color

  def initialize(color: 'white')
    @color = color
  end

  def to_s
    case color
    when 'white'
      "\u2655"
    when 'black'
      "\u265B"
    end
  end
end
