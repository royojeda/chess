require './lib/board'
require './lib/player'

class Game
  attr_reader :board, :players
  attr_accessor :error, :start, :move

  def initialize(board: Board.new,
                 error: nil,
                 start: nil,
                 move: nil,
                 player_one: Player.new(color: 'white'),
                 player_two: Player.new(color: 'black'))
    @board = board
    @error = error
    @start = start
    @move = move
    @players = [player_one, player_two]
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

  def execute_move
    board.move(start, move)
  end

  def select_move
    loop do
      display
      choose_destination
      if valid_move?
        self.error = ''
        break
      end
      self.error = 'Invalid move.'
    end
  end

  def choose_destination
    self.move = current_player.choose_destination
  end

  def valid_move?
    board.valid_move?(move)
  end

  def show_moves_from_start
    board.show_moves_from(start)
  end

  def select_start
    loop do
      display
      select_piece
      check_errors
      break if valid_start?
    end
  end

  def valid_start?
    error.nil?
  end

  def select_piece
    self.start = current_player.select_piece
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
    input.length == 2 &&
      input[0].match?(/^[a-h]$/) &&
      input[1].match?(/^[1-8]$/)
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
