require './lib/Pieces/piece'

class Bishop < Piece
  def moves
    [up_right_moves, up_left_moves, down_right_moves, down_left_moves]
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
    "\u2657"
  end

  def color_black
    "\u265D"
  end
end
