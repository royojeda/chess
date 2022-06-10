class Piece
  attr_reader :color

  def initialize(**opts)
    @color = opts[:color]
    post_initialize
  end

  def post_initialize
  end

  def all_fins(board, square)
    arr = []
    moves.each do |direction|
      direction.each do |move|
        break if board.square_at(square.fin_from(move)).nil? ||
                 board.square_at(square.fin_from(move)).own_piece?(color)

        arr << square.fin_from(move)
        break if board.square_at(square.fin_from(move)).enemy_piece?(color)
      end
    end
    arr
  end
end
