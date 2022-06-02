class Bishop
  attr_reader :color

  def initialize(color: 'white')
    @color = color
  end

  def to_s
    case color
    when 'white'
      "\u2657"
    when 'black'
      "\u265D"
    end
  end
end
