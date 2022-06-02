class Knight
  attr_reader :color

  def initialize(color: 'white')
    @color = color
  end

  def to_s
    case color
    when 'white'
      "\u2658"
    when 'black'
      "\u265E"
    end
  end
end
