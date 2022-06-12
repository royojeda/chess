require './lib/Pieces/piece'

class Queen < Piece
  def moves
    [upward_moves, downward_moves, leftward_moves, rightward_moves,
     up_right_moves, up_left_moves, down_right_moves, down_left_moves]
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

  def up_right_moves
    (1..7).map do |i|
      [i, i]
    end
  end

  def up_left_moves
    (1..7).map do |i|
      [-i, i]
    end
  end

  def down_right_moves
    (1..7).map do |i|
      [i, -i]
    end
  end

  def down_left_moves
    (1..7).map do |i|
      [-i, -i]
    end
  end

  def color_white
    "\u2655"
  end

  def color_black
    "\u265B"
  end
end
