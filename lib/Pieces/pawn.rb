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

    captures.each do |capture|
      arr << square.fin_from(capture) if board.enemy_piece_at?(color, square.fin_from(capture))
    end

    arr
  end

  def moves
    arr = [one_forward]

    if first_move
      self.first_move = false
      arr << two_forward
    end

    [arr]
  end

  def captures
    [front_left, front_right]
  end

  def one_forward
    color == 'white' ? [0, 1] : [0, -1]
  end

  def two_forward
    color == 'white' ? [0, 2] : [0, -2]
  end

  def front_left
    color == 'white' ? [-1, 1] : [1, -1]
  end

  def front_right
    color == 'white' ? [1, 1] : [-1, -1]
  end

  def color_white
    "\u2659"
  end

  def color_black
    "\u265F"
  end
end
