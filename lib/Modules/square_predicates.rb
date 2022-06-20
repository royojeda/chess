module SquarePredicates
  def can_castle?(color)
    contains_own_rook?(color) && occupant.first_move
  end

  def contains_own_king?(color)
    own_piece?(color) && contains_king?
  end

  def contains_king?
    occupant.is_a?(King)
  end

  def contains_pawn?
    occupant.is_a?(Pawn)
  end

  def contains_enemy_pawn?(color)
    enemy_piece?(color) && contains_pawn?
  end

  def promotable?
    contains_pawn? && on_last_rank?
  end

  def own_piece?(color)
    !empty? && owned_by?(color)
  end

  def enemy_piece?(color)
    !empty? && !owned_by?(color)
  end

  def empty?
    occupant == ' '
  end

  def owned_by?(color)
    occupant.color == color
  end

  private

  def contains_own_rook?(color)
    own_piece?(color) && contains_rook?
  end

  def contains_rook?
    occupant.is_a?(Rook)
  end

  def on_last_rank?
    rank == last_rank
  end

  def file_and_rank_odd?
    file.ord.odd? && rank.to_i.odd?
  end

  def file_and_rank_even?
    file.ord.even? && rank.to_i.even?
  end
end
