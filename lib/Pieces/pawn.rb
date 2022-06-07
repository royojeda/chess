class Pawn
  attr_reader :color
  attr_accessor :first_move

  def initialize(color:, first_move: true)
    @color = color
    @first_move = first_move
  end

  def moves
    case color
    when 'white'
      first_move ? [[0, 1], [0, 2]] : [[0, 1]]
    when 'black'
      first_move ? [[0, -1], [0, -2]] : [[0, -1]]
    end
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
    "\u2659"
  end

  def color_black
    "\u265F"
  end
end
