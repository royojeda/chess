module EndConditions
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
end
