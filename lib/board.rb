require './lib/square'

class Board
  attr_accessor :squares

  def initialize(squares: starting_condition)
    @squares = squares
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

  def highlight_piece_at(move)
    square_at(move).select_as_start
  end

  def empty_at?(move)
    square_at(move).empty?
  end

  def piece_owned?(player, move)
    square_at(move).owned_by?(player)
  end

  def square_at(move)
    location = move.chars
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
