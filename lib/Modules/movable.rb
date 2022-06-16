module Movable
  def upward_moves(max = default_max)
    each_step(max) { |i| [0, i] }
  end

  def downward_moves(max = default_max)
    each_step(max) { |i| [0, -i] }
  end

  def leftward_moves(max = default_max)
    each_step(max) { |i| [-i, 0] }
  end

  def rightward_moves(max = default_max)
    each_step(max) { |i| [i, 0] }
  end

  def up_right_moves(max = default_max)
    each_step(max) { |i| [i, i] }
  end

  def up_left_moves(max = default_max)
    each_step(max) { |i| [-i, i] }
  end

  def down_right_moves(max = default_max)
    each_step(max) { |i| [i, -i] }
  end

  def down_left_moves(max = default_max)
    each_step(max) { |i| [-i, -i] }
  end

  def each_step(max, &proc)
    (1..max).map { |i| proc.call(i) }
  end

  def default_max
    7
  end
end
