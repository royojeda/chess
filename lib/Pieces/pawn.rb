require './lib/Pieces/piece'

class Pawn < Piece
  attr_accessor :first_move

  def post_initialize
    @first_move = true
  end

  def all_destinations(board, square)
    arr = []

    moves.each do |direction|
      direction.each do |move|
        destination = square.destination_from(move)
        break if board.out_of_bounds?(destination) ||
                 !board.square_at(destination).empty?

        arr << destination
      end
    end

    captures.each do |capture|
      destination = square.destination_from(capture)
      arr << destination if board.enemy_piece_at?(color, destination)
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
