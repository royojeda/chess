require './lib/board'
require './lib/player'
require './lib/Modules/promotion'
require './lib/Modules/notices'
require './lib/Modules/input_checker'
require './lib/Modules/turn_actions'
require './lib/Modules/end_conditions'

class Game
  include Promotion
  include Notices
  include InputChecker
  include TurnActions
  include EndConditions

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
