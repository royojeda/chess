module TurnActions
  def check?(player)
    board.check?(player.color)
  end

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
end
