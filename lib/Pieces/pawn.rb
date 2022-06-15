require './lib/Pieces/piece'

class Pawn < Piece
  def location
    [square.file, square.rank]
  end

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
    arr = [one_forward]
    arr << two_forward if first_move
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
