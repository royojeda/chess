require './lib/Pieces/piece'
require './lib/Modules/movable'

class Pawn < Piece
  include Movable

  def previous_is_two_forward?
    square.rank == (previous.rank.ord + 2).chr ||
      square.rank == (previous.rank.ord - 2).chr
  end

  def all_destinations(board)
    arr = []

    moves.each do |direction|
      direction.each do |move|
        destination = destination_from(move)
        break if board.out_of_bounds?(destination) ||
                 !board.square_at(destination).empty?

        arr << destination
      end
    end

    captures.each do |capture|
      destination = destination_from(capture)
      arr << destination if board.enemy_piece_at?(color, destination) ||
                            board.allows_en_passant_by?(self, capture[0])
    end

    arr
  end

  def moves
    first_move ? two_forward : one_forward
  end

  def captures
    front_left + front_right
  end

  def one_forward
    color == 'white' ? [upward_moves(1)] : [downward_moves(1)]
  end

  def two_forward
    color == 'white' ? [upward_moves(2)] : [downward_moves(2)]
  end

  def front_left
    color == 'white' ? up_left_moves(1) : down_right_moves(1)
  end

  def front_right
    color == 'white' ? up_right_moves(1) : down_left_moves(1)
  end

  def color_white
    "\u2659"
  end

  def color_black
    "\u265F"
  end
end
