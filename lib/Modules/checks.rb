module Checks
  def check?(color)
    all_enemy_moves(color).include?(square_of_own_king(color))
  end

  def all_enemy_moves(color)
    arr = []
    enemy_squares(color).each do |square|
      next if square.contains_king?

      destinations = square.all_destinations(self)
      arr.concat(squares_at(destinations).compact)
    end
    arr
  end

  def square_of_own_king(color)
    squares.find do |square|
      square.contains_own_king?(color)
    end
  end

  def all_own_moves(color)
    arr = []
    own_squares(color).each do |square|
      destinations = square.all_destinations(self).compact
      valids = destinations.select do |move|
        no_check_after?([square.file, square.rank], move)
      end
      arr.concat(squares_at(valids))
    end
    arr
  end

  def enemy_squares(color)
    squares.select do |square|
      square.enemy_piece?(color)
    end
  end

  def own_squares(color)
    squares.select do |square|
      square.own_piece?(color)
    end
  end
end
