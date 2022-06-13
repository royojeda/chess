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

  def out_of_bounds?(location)
    square_at(location).nil?
  end

  def move(start, move)
    source = square_at(start)
    destination = square_at(move)
    source.store_as_previous
    destination.update_occupant(source)
    source.remove_occupant
    self.last_piece_to_move = destination.occupant
    squares.each(&:highlight_none)
  end

  def show_moves_from(location)
    start = square_at(location)
    start.highlight_blue
    destinations = start.all_destinations(self)
    self.valid_moves = squares_at(destinations).compact
    valid_moves.each(&:highlight_green)
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
