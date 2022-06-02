class Pawn
  attr_reader :color

  def initialize(color: 'white')
    @color = color
  end

  def to_s
    case color
    when 'white'
      "\u2659"
    when 'black'
      "\u265F"
    end
  end
end
