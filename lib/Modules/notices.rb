module Notices
  def checkmate_notice
    "Checkmate! #{other_player.color.capitalize} wins!"
  end

  def stalemate_notice
    'Stalemate! The game ends in a draw.'
  end

  def check_notice
    'Check!'
  end

  def no_moves_error
    'That piece has no valid moves for this turn.'
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
end
