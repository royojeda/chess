module InputChecker
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
