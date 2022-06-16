module Movable
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
end