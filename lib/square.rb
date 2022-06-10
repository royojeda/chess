require './lib/Pieces/pawn'
require './lib/Pieces/rook'
require './lib/Pieces/knight'
require './lib/Pieces/bishop'
require './lib/Pieces/queen'
require './lib/Pieces/king'

class Square
  attr_reader :rank, :file, :color
  attr_accessor :status, :occupant

  def initialize(file:, rank:, status: '')
    @file = file
    @rank = rank
    @status = status
    @color = determine_color
    @occupant = determine_occupant
  end

  def highlight_none
    self.status = ''
  end

  def remove_occupant
    self.occupant = ' '
  end

  def update_occupant(source)
    self.occupant = source.occupant
  end

  def highlight_blue
    self.status = 'blue'
  end

  def highlight_green
    self.status = 'green'
  end

  def own_piece?(color)
    !empty? && occupant.color == color
  end

  def enemy_piece?(color)
    !empty? && occupant.color != color
  end

  def all_fins(board)
    # arr = []
    # moves.each do |direction|
    #   direction.each do |move|
    #     break if board.square_at(fin_from(move)).nil? ||
    #              board.square_at(fin_from(move)).own_piece?(occupant.color)

    #     arr << fin_from(move)
    #     break if board.square_at(fin_from(move)).enemy_piece?(occupant.color)
    #   end
    # end
    # arr
    occupant.all_fins(board, self)
  end

  def fin_from(move)
    [fin_file(move[0]), fin_rank(move[1])]
  end

  def fin_file(horizontal_move)
    (file.ord + horizontal_move).chr
  end

  def fin_rank(vertical_move)
    (rank.ord + vertical_move).chr
  end

  def moves
    occupant.moves
  end

  def empty?
    occupant == ' '
  end

  def owned_by?(player)
    occupant.color == player.color
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
    end.new(color:)
  end
  # rubocop:enable Metrics/MethodLength

  def create_pawn(color)
    Pawn.new(color:)
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

  def file_and_rank_odd?
    file.ord.odd? && rank.to_i.odd?
  end

  def file_and_rank_even?
    file.ord.even? && rank.to_i.even?
  end

  def to_s
    "\e[30;48;5;#{background_color}m#{occupant}\e[0m"
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
