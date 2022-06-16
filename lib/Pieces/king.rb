require './lib/Pieces/piece'

class King < Piece
  def moves
    upward_moves = [[0, 1]]
    downward_moves = [[0, -1]]
    leftward_moves = [[-1, 0]]
    rightward_moves = [[1, 0]]
    up_right_moves = [[1, 1]]
    up_left_moves = [[-1, 1]]
    down_right_moves = [[1, -1]]
    down_left_moves = [[-1, -1]]

    [upward_moves, downward_moves, leftward_moves, rightward_moves,
     up_right_moves, up_left_moves, down_right_moves, down_left_moves]
  end

  def all_destinations(board)
    arr = super

    castles.each do |castle|
      destination = destination_from(castle)
      arr << destination if valid_castle?(destination, board)
    end

    arr
  end

  def valid_castle?(destination, board)
    if destination[0] > square.file
      locations_in_king_path = [first_right] + [second_right]
      locations_between_king_and_rook = locations_in_king_path
      rook_square = third_right
    else
      locations_in_king_path = [first_left] + [second_left]
      locations_between_king_and_rook = locations_in_king_path + [third_left]
      rook_square = fourth_left
    end
    !board.check?(color) && first_move &&
      locations_between_king_and_rook.all? do |location|
        board.empty_at?(location)
      end &&
      locations_in_king_path.none? do |location|
        board.attacked?(color, location)
      end &&
      board.can_castle?(color, rook_square)
  end

  def first_right
    [(square.file.ord + 1).chr, square.rank]
  end

  def second_right
    [(square.file.ord + 2).chr, square.rank]
  end

  def third_right
    [(square.file.ord + 3).chr, square.rank]
  end

  def first_left
    [(square.file.ord - 1).chr, square.rank]
  end

  def second_left
    [(square.file.ord - 2).chr, square.rank]
  end

  def third_left
    [(square.file.ord - 3).chr, square.rank]
  end

  def fourth_left
    [(square.file.ord - 4).chr, square.rank]
  end

  def castles
    [[2, 0], [-2, 0]]
  end

  def color_white
    "\u2654"
  end

  def color_black
    "\u265A"
  end
end
