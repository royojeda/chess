require './lib/Pieces/pawn'
require './lib/Pieces/rook'
require './lib/Pieces/knight'
require './lib/Pieces/bishop'
require './lib/Pieces/queen'
require './lib/Pieces/king'
require './lib/Modules/square_predicates'

class Square
  include SquarePredicates

  attr_reader :rank, :file, :color
  attr_accessor :status, :occupant

  def initialize(file:, rank:, status: '')
    @file = file
    @rank = rank
    @status = status
    @color = determine_color
    @occupant = determine_occupant
  end

  def place(piece)
    self.occupant = piece
  end

  def store_as_previous
    occupant.previous = self
  end

  def highlight_none
    self.status = ''
  end

  def remove_occupant
    self.occupant = ' '
  end

  def update_occupant(source)
    self.occupant = source.occupant
    occupant.square = self
    occupant.moved
  end

  def last_rank
    occupant.color == 'white' ? '8' : '1'
  end

  def highlight_blue
    self.status = 'blue'
  end

  def highlight_green
    self.status = 'green'
  end

  def all_destinations(board)
    occupant.all_destinations(board)
  end

  # rubocop:disable Metrics/MethodLength
  def determine_occupant
    case rank
    when '1'
      create_non_pawn('white')
    when '2'
      create_pawn('white')
    when '7'
      create_pawn('black')
    when '8'
      create_non_pawn('black')
    else
      ' '
    end
  end

  def create_non_pawn(color)
    case file
    when 'a', 'h'
      Rook
    when 'b', 'g'
      Knight
    when 'c', 'f'
      Bishop
    when 'd'
      Queen
    when 'e'
      King
    end.new(color:, square: self)
  end
  # rubocop:enable Metrics/MethodLength

  def create_pawn(color)
    Pawn.new(color:, square: self)
  end

  def determine_color
    if file_and_rank_odd? || file_and_rank_even?
      color_dark
    else
      color_light
    end
  end

  def color_dark
    'dark'
  end

  def color_light
    'light'
  end

  def to_s
    "\e[38;5;#{font_color};48;5;#{background_color}m#{occupant} \e[0m"
  end

  def font_color
    16
  end

  def background_color
    case status
    when 'blue'
      background_blue
    when 'green'
      background_green
    else
      normal_color
    end
  end

  def normal_color
    case color
    when 'light'
      background_light
    when 'dark'
      background_dark
    end
  end

  def background_blue
    81
  end

  def background_green
    84
  end

  def background_light
    223
  end

  def background_dark
    3
  end
end
