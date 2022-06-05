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

  def square_at(rank, file)
    squares.find { |square| square.rank == rank && square.file == file }
  end

  def display
    each_location do |rank, file|
      print square_at(rank, file).occupant
      puts if file == 'h'
    end
  end
end

a = Board.new
a.display
