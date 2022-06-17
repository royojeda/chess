module BoardPredicates
  def no_moves_for?(location)
    arr = []
    square = square_at(location)
    destinations = square.all_destinations(self).compact
    valids = destinations.select do |move|
      no_check_after?([square.file, square.rank], move)
    end
    arr.concat(squares_at(valids))
    arr.empty?
  end

  def attacked?(color, location)
    all_enemy_moves(color).include?(square_at(location))
  end

  def out_of_bounds?(location)
    square_at(location).nil?
  end

  def allows_en_passant_by?(attacker, side)
    location = attacker.location
    location[0] = (file(location).ord + side).chr
    enemy_pawn_at?(attacker.color, location) &&
      chance_not_passed(location) &&
      piece_at(location).previous_is_two_forward?
  end

  def enemy_pawn_at?(color, location)
    !out_of_bounds?(location) &&
      square_at(location).contains_enemy_pawn?(color)
  end

  def all_empty?(locations)
    locations.all? do |location|
      empty_at?(location)
    end
  end

  def none_attacked?(color, locations)
    locations.none? do |location|
      attacked?(color, location)
    end
  end

  def castle?(start, move)
    source = square_at(start)
    destination = square_at(move)
    destination.contains_king? &&
      source.rank == destination.rank &&
      (source.file.ord + 1).chr != destination.file &&
      (source.file.ord - 1).chr != destination.file
  end

  def promotable?(move)
    destination = square_at(move)
    destination.promotable?
  end

  def en_passant?(source, destination)
    destination.contains_pawn? && source.file != destination.file
  end

  def no_check_after?(start, destination)
    save_squares = Marshal.dump(squares)

    source = square_at(start)
    fin = square_at(destination)
    fin.update_occupant(source)
    source.remove_occupant
    square_behind(fin).remove_occupant if en_passant?(source, fin)

    color = piece_at(destination).color
    result = !check?(color)
    self.squares = Marshal.load(save_squares)
    result
  end

  def valid_move?(location)
    valid_moves.any? do |move|
      move.file == file(location) && move.rank == rank(location)
    end
  end

  def empty_at?(location)
    square_at(location).empty?
  end

  def own_piece_at?(color, location)
    square_at(location).own_piece?(color)
  end

  def enemy_piece_at?(color, location)
    !out_of_bounds?(location) &&
      square_at(location).enemy_piece?(color)
  end

  def can_castle?(color, location)
    square_at(location).can_castle?(color)
  end

  def right_side_castle?(move)
    file(move) == 'g'
  end
end
