require './lib/board'
require './lib/player'
require './lib/Modules/promotion'
require './lib/Modules/notices'
require './lib/Modules/input_checker'

class Game
  include Promotion
  include Notices
  include InputChecker

  attr_reader :players
  attr_accessor :notice, :start, :move, :board

  def initialize(board: Board.new,
                 players: [Player.new(color: 'white'),
                           Player.new(color: 'black')],
                 notice: nil,
                 start: nil,
                 move: nil)
    @board = board
    @players = players
    @notice = notice
    @start = start
    @move = move
  end

  def play
    loop do
      break if over?

      turn
      return true if start == 'save'.chars
    end
    display
    false
  end

  def over?
    return false unless no_valid_moves_for?(current_player)

    check?(current_player) ? checkmate : stalemate
  end

  def checkmate
    self.notice = checkmate_notice
  end

  def stalemate
    self.notice = stalemate_notice
  end

  def no_valid_moves_for?(player)
    board.all_own_moves(player.color).empty?
  end

  def check?(player)
    board.check?(player.color)
  end

  # rubocop:disable Metrics/MethodLength
  def turn
    check_check
    board_save = Marshal.dump(board)
    loop do
      select_start
      return if save?

      show_moves_from_start
      select_move
      break unless changed_mind?

      self.board = Marshal.load(board_save)
    end
    execute_move
    switch_players
  end
  # rubocop:enable Metrics/MethodLength

  def save?
    start == 'save'.chars
  end

  def select_start
    loop do
      display
      select_piece
      check_start_errors unless save?
      break if save? || valid_input?
    end
  end

  def show_moves_from_start
    board.show_moves_from(start)
  end

  def select_move
    loop do
      display
      choose_destination
      check_move_errors unless changed_mind?
      break if changed_mind? || valid_input?
    end
  end

  def changed_mind?
    move == start
  end

  def execute_move
    board.move(start, move)
    promote if board.promotable?(move)
    board.rook_castle_move(move) if board.castle?(start, move)
  end

  def choose_destination
    self.move = current_player.choose_destination
  end

  def select_piece
    self.start = current_player.select_piece
  end

  def check_check
    self.notice = check_notice if board.check?(current_player.color)
  end

  def switch_players
    players.rotate!
  end

  def current_player
    players.first
  end

  def other_player
    players.last
  end

  def display
    system 'clear'
    puts notice
    puts
    board.display
    puts
  end
end
