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
    arr = []
    moves.each do |direction|
      direction.each do |move|
        destination = destination_from(move)
        break if board.out_of_bounds?(destination) ||
                 board.own_piece_at?(color, destination)

        arr << destination
        break if board.enemy_piece_at?(color, destination)
      end
    end

    castles.each do |castle|
      destination = destination_from(castle)
      arr << destination if valid_castle?(destination, board)
    end

    arr
  end

  def valid_castle?(destination, board)
    !board.check?(color) && first_move &&
      if destination[0] > square.file
        first_right = [(square.file.ord + 1).chr, square.rank]
        second_right = [(square.file.ord + 2).chr, square.rank]
        third_right = [(square.file.ord + 3).chr, square.rank]
        board.empty_at?(first_right) &&
          board.empty_at?(second_right) &&
          !board.attacked?(color, first_right) &&
          !board.attacked?(color, second_right) &&
          board.can_castle?(color, third_right)
      else
        first_left = [(square.file.ord - 1).chr, square.rank]
        second_left = [(square.file.ord - 2).chr, square.rank]
        third_left = [(square.file.ord - 3).chr, square.rank]
        fourth_left = [(square.file.ord - 4).chr, square.rank]
        board.empty_at?(first_left) &&
          board.empty_at?(second_left) &&
          board.empty_at?(third_left) &&
          !board.attacked?(color, first_left) &&
          !board.attacked?(color, second_left) &&
          board.can_castle?(color, fourth_left)
      end
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
