class Pawn
  attr_reader :color, :moves

  def initialize(color: 'white', moves: [[0, 1], [0, 2]])
    @color = color
    @moves = moves
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
