require './lib/square'
require './lib/pawn'
require './lib/rook'
require './lib/knight'
require './lib/bishop'
require './lib/queen'
require './lib/king'

class Board
  attr_reader :squares

  def initialize
    @squares = starting_arrangement
  end

  def starting_arrangement
    empty_squares = make_empty_squares
    insert_starting_pieces(empty_squares)
  end

  def make_empty_squares
    arr = []
    colors = ['dark', 'light']
    rank = 1
    while rank <= 8
      file = 'a'
      while file <= 'h'
        color = colors[0]
        arr.push(Square.new(rank:, file:, color:))
        colors.rotate!
        file = file.next
      end
      colors.rotate!
      rank += 1
    end
    arr
  end

  def insert_starting_pieces(squares)
    squares.each do |square|
      case square.rank
      when 1
        color = 'white'
        case square.file
        when 'a', 'h'
          square.occupant = Rook.new(color:)
        when 'b', 'g'
          square.occupant = Knight.new(color:)
        when 'c', 'f'
          square.occupant = Bishop.new(color:)
        when 'd'
          square.occupant = Queen.new(color:)
        when 'e'
          square.occupant = King.new(color:)
        end
      when 2
        color = 'white'
        square.occupant = Pawn.new(color:)
      when 7
        color = 'black'
        square.occupant = Pawn.new(color:)
      when 8
        color = 'black'
        case square.file
        when 'a', 'h'
          square.occupant = Rook.new(color:)
        when 'b', 'g'
          square.occupant = Knight.new(color:)
        when 'c', 'f'
          square.occupant = Bishop.new(color:)
        when 'd'
          square.occupant = Queen.new(color:)
        when 'e'
          square.occupant = King.new(color:)
        end
      end
    end
  end

  def to_s
    <<~TEXT
      #{squares[56]}#{squares[57]}#{squares[58]}#{squares[59]}#{squares[60]}#{squares[61]}#{squares[62]}#{squares[63]}
      #{squares[48]}#{squares[49]}#{squares[50]}#{squares[51]}#{squares[52]}#{squares[53]}#{squares[54]}#{squares[55]}
      #{squares[40]}#{squares[41]}#{squares[42]}#{squares[43]}#{squares[44]}#{squares[45]}#{squares[46]}#{squares[47]}
      #{squares[32]}#{squares[33]}#{squares[34]}#{squares[35]}#{squares[36]}#{squares[37]}#{squares[38]}#{squares[39]}
      #{squares[24]}#{squares[25]}#{squares[26]}#{squares[27]}#{squares[28]}#{squares[29]}#{squares[30]}#{squares[31]}
      #{squares[16]}#{squares[17]}#{squares[18]}#{squares[19]}#{squares[20]}#{squares[21]}#{squares[22]}#{squares[23]}
      #{squares[8]}#{squares[9]}#{squares[10]}#{squares[11]}#{squares[12]}#{squares[13]}#{squares[14]}#{squares[15]}
      #{squares[0]}#{squares[1]}#{squares[2]}#{squares[3]}#{squares[4]}#{squares[5]}#{squares[6]}#{squares[7]}
    TEXT
  end
end
