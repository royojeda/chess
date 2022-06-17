require './lib/square'
require './lib/Modules/board_predicates'
require './lib/Modules/checks'

class Board
  include BoardPredicates
  include Checks

  attr_accessor :squares, :valid_moves, :last_piece_to_move

  def initialize(squares: starting_condition)
    @squares = squares
    @valid_moves = nil
    @last_piece_to_move = nil
  end

  def starting_condition
    arr = []
    each_location { |rank, file| arr << Square.new(rank: rank, file: file) }
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

  def chance_not_passed(location)
    location == last_piece_to_move.location
  end

  def piece_at(location)
    square_at(location).occupant
  end

  def move(start, move)
    source = square_at(start)
    destination = square_at(move)
    core_move(source, destination)
    square_behind(destination).remove_occupant if en_passant?(source, destination)
    self.last_piece_to_move = destination.occupant
    squares.each(&:highlight_none)
    source.highlight_blue
    destination.highlight_blue
  end

  def core_move(source, destination)
    source.store_as_previous
    destination.update_occupant(source)
    source.remove_occupant
  end

  def rook_castle_move(move)
    start = [rook_start_file(move), rank(move)]
    fin = [rook_end_file(move), rank(move)]
    source = square_at(start)
    destination = square_at(fin)
    core_move(source, destination)
  end

  def rook_start_file(move)
    right_side_castle?(move) ? 'h' : 'a'
  end

  def rook_end_file(move)
    right_side_castle?(move) ? 'f' : 'd'
  end

  def place(piece, location)
    square_at(location).place(piece)
  end

  def square_behind(square)
    offset = square.owned_by?('white') ? -1 : 1
    location = [square.file, (square.rank.ord + offset).chr]
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

  def file(location)
    location[0]
  end

  def rank(location)
    location[1]
  end

  def squares_at(locations)
    locations.map { |location| square_at(location) }
  end

  def square_at(location)
    squares.find do |square|
      square.file == file(location) && square.rank == rank(location)
    end
  end

  def display
    squares.each do |square|
      print "     #{square.rank}" if square.file == 'a'
      print square
      puts if square.file == 'h'
    end
    puts '      A B C D E F G H'
  end
end
