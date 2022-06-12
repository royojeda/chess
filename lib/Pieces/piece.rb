class Piece
  attr_reader :color

  def initialize(**opts)
    @color = opts[:color]
    post_initialize
  end

  def post_initialize; end

  def all_fins(board, square)
    arr = []
    moves.each do |direction|
      direction.each do |move|
        break if board.out_of_bounds?(square.fin_from(move)) ||
                 board.own_piece_at?(color, square.fin_from(move))

        arr << square.fin_from(move)
        break if board.enemy_piece_at?(color, square.fin_from(move))
      end
    end
    arr
  end

  def to_s
    case color
    when 'white'
      color_white
    when 'black'
      color_black
    end
  end
end
