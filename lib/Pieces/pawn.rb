class Pawn
  attr_reader :color
  attr_accessor :first_move

  def initialize(color:, first_move: true)
    @color = color
    @first_move = first_move
  end

  def moves
    sign = move_direction
    arr = [[0, "#{sign}1".to_i]]
    if first_move
      self.first_move = false
      arr << [0, "#{sign}2".to_i]
    end
    [arr]
  end

  def move_direction
    color == 'white' ? '+' : '-'
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
