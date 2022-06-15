require './lib/square'

class Board
  attr_accessor :squares, :valid_moves, :last_piece_to_move

  def initialize(squares: starting_condition)
    @squares = squares
    @valid_moves = nil
    @last_piece_to_move = nil
  end

  def starting_condition
    arr = []
    each_location { |rank, file| arr << Square.new(rank:, file:) }
    arr
  end

  def each_location(&proc)
    ranks.each do |rank|
      files.each do |file|
        proc.call(rank, file)
      end
    end
  end

  def ranks
    ('1'..'8').to_a.reverse
  end

  def files
    ('a'..'h').to_a
  end

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

  def square_of_own_king(color)
    squares.find do |square|
      square.contains_own_king?(color)
    end
  end

  def attacked?(color, location)
    all_enemy_moves(color).include?(square_at(location))
  end

  def all_enemy_moves(color)
    other_player_squares = squares.select do |square|
      square.enemy_piece?(color)
    end
    arr = []
    other_player_squares.each do |square|
      next if square.contains_king?

      destinations = square.all_destinations(self)
      arr.concat(squares_at(destinations).compact)
    end
    arr
  end

  def all_own_moves(color)
    current_player_squares = squares.select do |square|
      square.own_piece?(color)
    end
    arr = []
    current_player_squares.each do |square|
      destinations = square.all_destinations(self).compact
      valids = destinations.select do |move|
        no_check_after?([square.file, square.rank], move)
      end
      arr.concat(squares_at(valids))
    end
    arr
  end

  def checkmate?(color)
    check?(color) && all_own_moves(color).empty?
  end

  def check?(color)
    all_enemy_moves(color).include?(square_of_own_king(color))
  end

  def out_of_bounds?(location)
    square_at(location).nil?
  end

  def allows_en_passant_by?(attacker, side)
    location = attacker.location
    location[0] = (location[0].ord + side).chr
    enemy_pawn_at?(attacker.color, location) &&
      piece_at(location) == last_piece_to_move &&
      piece_at(location).previous_is_two_forward?
  end

  def piece_at(location)
    square_at(location).occupant
  end

  def enemy_pawn_at?(color, location)
    !out_of_bounds?(location) &&
      square_at(location).contains_enemy_pawn?(color)
  end

  def can_castle?(color, location)
    square_at(location).can_castle?(color)
  end

  def move(start, move)
    source = square_at(start)
    destination = square_at(move)
    source.store_as_previous
    destination.update_occupant(source)
    source.remove_occupant
    square_behind(destination).remove_occupant if en_passant?(source, destination)
    # move().remove_occupant if castle?(source, destination)
    self.last_piece_to_move = destination.occupant
    squares.each(&:highlight_none)
    source.highlight_blue
    destination.highlight_blue
  end

  def place(piece, move)
    square_at(move).place(piece)
  end

  def promotable?(move)
    destination = square_at(move)
    destination.promotable?
  end

  def en_passant?(source, destination)
    destination.contains_pawn? && source.file != destination.file
  end

  def square_behind(square)
    location = if square.owned_by?('white')
                 [square.file, (square.rank.ord - 1).chr]
               else
                 [square.file, (square.rank.ord + 1).chr]
               end
    square_at(location)
  end

  def show_moves_from(location)
    start = square_at(location)
    start.highlight_blue
    destinations = start.all_destinations(self).compact
    valids = destinations.select do |move|
      no_check_after?(location, move)
    end
    self.valid_moves = squares_at(valids)
    valid_moves.each(&:highlight_green)
  end

  def no_check_after?(start, destination)
    save = Marshal.dump(squares)
    move(start, destination)
    color = square_at(destination).occupant.color
    result = !check?(color)
    self.squares = Marshal.load(save)
    result
  end

  def valid_move?(location)
    file = location[0]
    rank = location[1]
    valid_moves.any? do |move|
      move.file == file && move.rank == rank
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

  def squares_at(locations)
    locations.map { |location| square_at(location) }
  end

  def square_at(location)
    file = location[0]
    rank = location[1]
    squares.find { |square| square.rank == rank && square.file == file }
  end

  def display
    squares.each do |square|
      print square.rank if square.file == 'a'
      print square
      puts if square.file == 'h'
    end
    puts ' ABCDEFGH'
  end
end
