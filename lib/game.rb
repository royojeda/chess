require './lib/board'
require './lib/player'

class Game
  attr_reader :board, :players
  attr_accessor :error, :start

  def initialize(board: Board.new,
                 error: nil,
                 start: nil,
                 player_one: Player.new(color: 'white'),
                 player_two: Player.new(color: 'black'))
    @board = board
    @error = error
    @start = start
    @players = [player_one, player_two]
  end

  def turn
    select_start
    highlight_piece
  end

  def highlight_piece
    board.highlight_piece_at(start)
  end

  def select_start
    loop do
      display
      self.start = select_piece
      check_errors
      break if valid_start?
    end
  end

  def valid_start?
    error.nil?
  end

  def select_piece
    current_player.select_piece
  end

  def check_errors
    self.error = if !valid_format?(start)
                   invalid_format_error
                 elsif board.empty_at?(start)
                   empty_square_error
                 elsif !board.piece_owned?(current_player, start)
                   unowned_piece_error
                 end
  end

  def valid_format?(input)
    input.match?(/^[a-h][1-8]$/)
  end

  def invalid_format_error
    'Invalid format.'
  end

  def empty_square_error
    'That square is empty.'
  end

  def unowned_piece_error
    'That piece is not yours.'
  end

  def current_player
    players.first
  end

  def display
    system 'clear'
    puts error
    puts
    board.display
    puts
  end
end
