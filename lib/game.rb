require './lib/board'
require './lib/player'

class Game
  attr_reader :board, :players
  attr_accessor :error

  def initialize(board: Board.new,
                 error: nil,
                 player_one: Player.new(color: 'white'),
                 player_two: Player.new(color: 'black'))
    @board = board
    @error = error
    @players = [player_one, player_two]
  end

  def turn
    make_valid_move
  end

  def make_valid_move
    loop do
      display
      current_player.make_move
      check_errors
      break if valid_move?
    end
  end

  def valid_move?
    error.nil?
  end

  def move
    current_player.move
  end

  def check_errors
    self.error = if !valid_format?(move)
                   invalid_format_error
                 elsif board.empty_at?(move)
                   empty_square_error
                 elsif !board.piece_owned?(current_player, move)
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
