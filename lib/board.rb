require './lib/square'

class Board
  attr_reader :squares

  def initialize
    @squares = make_empty_squares
  end

  def make_empty_squares
    arr = []
    rank = 1
    while rank <= 8
      file = 'a'
      while file <= 'h'
        arr.push(Square.new(rank: rank, file: file))
        file = file.next
      end
      rank += 1
    end
    arr
  end
end

puts Board.new.squares
