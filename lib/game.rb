require "./lib/board"
require "./lib/player"
require "./lib/Modules/notices"

class Game
  include Notices

  attr_reader :players
  attr_accessor :notice, :start, :move, :board

  def initialize(board: Board.new,
    players: [Player.new(color: "white"),
      Player.new(color: "black")],
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
      return true if start == "save".chars
    end
    display
    false
  end

  private

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
    system "clear"
    puts notice
    puts
    board.display
    puts
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

  def promote
    self.notice = "Pawn promotion!"
    type = choose_replacement
    new_piece = type.new(color: current_player.color, square: board.square_at(move))
    board.place(new_piece, move)
    self.notice = nil
  end

  def choose_replacement(type = nil)
    while type.nil?
      display
      promotion_prompt
      choice = gets.chomp.to_i
      type = interpret_choice(choice)
    end
    type
  end

  def interpret_choice(choice)
    case choice
    when 1
      Queen
    when 2
      Rook
    when 3
      Bishop
    when 4
      Knight
    end
  end

  def promotion_prompt
    puts "Please select a replacement piece: (1 - Queen, 2 - Rook, 3 - Bishop, 4 - Knight)"
  end

  def check?(player)
    board.check?(player.color)
  end

  def save?
    start == "save".chars
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

  def check_start_errors
    self.notice = check_valid_format(start) ||
      check_empty_square_at(start) ||
      check_own_piece_at(start) ||
      check_no_moves(start)
  end

  def check_move_errors
    self.notice = check_valid_format(move) ||
      check_valid_move(move)
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

  def valid_input?
    notice.nil?
  end

  def check_no_moves(input)
    no_moves_error if board.no_moves_for?(input)
  end
end
