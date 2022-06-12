require './lib/Pieces/piece'

class Rook < Piece
  def post_initialize
    @first_move = true
  end

  def moves
    [upward_moves, downward_moves, leftward_moves, rightward_moves]
  end

  def upward_moves
    (1..7).map do |i|
      [0, i]
    end
  end

  def downward_moves
    (1..7).map do |i|
      [0, -i]
    end
  end

  def leftward_moves
    (1..7).map do |i|
      [-i, 0]
    end
  end

  def rightward_moves
    (1..7).map do |i|
      [i, 0]
    end
  end

  def color_white
    "\u2656"
  end

  def color_black
    "\u265C"
  end
end
