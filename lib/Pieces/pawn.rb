require './lib/Pieces/piece'

class Pawn < Piece
  attr_accessor :first_move

  def post_initialize
    @first_move = true
  end

  def all_fins(board, square)
    arr = []
    moves.each do |direction|
      direction.each do |move|
        break if board.out_of_bounds?(square.fin_from(move)) ||
                 !board.square_at(square.fin_from(move)).empty?

        arr << square.fin_from(move)
      end
    end
    arr
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
