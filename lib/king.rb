class King
  attr_reader :color

  def initialize(color: 'white')
    @color = color
  end

  def to_s
    case color
    when 'white'
      "\u2654"
    when 'black'
      "\u265E"
    end
  end
end
