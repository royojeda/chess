require './lib/board'
require './lib/player'

class Game
  attr_reader :board, :players
  attr_accessor :error, :start, :move

  def initialize
    @board = Board.new
    @error = nil
    @start = nil
    @move = nil
    @players = [Player.new(color: 'white'), Player.new(color: 'black')]
  end

  def play
    turn until over?
  end

  def over?
    # temporary
    false
  end

  def turn
    select_start
    show_moves_from_start
    select_move
    execute_move
    switch_players
  end

  def select_start
    loop do
      display
      select_piece
      check_start_errors
      break if valid_input?
    end
  end

  def show_moves_from_start
    board.show_moves_from(start)
  end

  def select_move
    loop do
      display
      choose_destination
      check_move_errors
      break if valid_input?
    end
  end

  def execute_move
    board.move(start, move)
  end

  def check_move_errors
    self.error = check_valid_format(move) ||
                 check_valid_move(move)
  end

  def choose_destination
    self.move = current_player.choose_destination
  end

  def valid_input?
    error.nil?
  end

  def select_piece
    self.start = current_player.select_piece
  end

  def check_start_errors
    self.error = check_valid_format(start) ||
                 check_empty_square_at(start) ||
                 check_own_piece_at(start)
  end

  def check_valid_move(input)
    invalid_move_error unless board.valid_move?(input)
  end

  def check_valid_format(input)
    invalid_format_error unless valid_format?(input)
  end

  def check_empty_square_at(input)
    empty_square_error if board.empty_at?(input)
  end

  def check_own_piece_at(input)
    unowned_piece_error unless board.own_piece_at?(current_player.color, input)
  end

  def valid_format?(input)
    input.length == 2 &&
      input[0].match?(/^[a-h]$/) &&
      input[1].match?(/^[1-8]$/)
  end

  def invalid_move_error
    'Invalid move.'
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

  def switch_players
    players.rotate!
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
