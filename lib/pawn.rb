class Pawn
  attr_reader :color, :moves
  attr_accessor :first_move

  def initialize(color:, first_move: true)
    @color = color
    @first_move = first_move
    @moves = calculate
  end

  def calculate
    case color
    when 'white'
      if first_move
        self.first_move = false
        [[0, 1], [0, 2]]
      else
        [[0, 1]]
      end
    when 'black'
      if first_move
        self.first_move = false
        [[0, -1], [0, -2]]
      else
        [[0, -1]]
      end
    end
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
