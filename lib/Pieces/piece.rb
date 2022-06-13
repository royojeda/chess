class Piece
  attr_reader :color

  def initialize(**opts)
    @color = opts[:color]
    post_initialize
  end

  def post_initialize; end

  def all_destinations(board, square)
    arr = []
    moves.each do |direction|
      direction.each do |move|
        destination = square.destination_from(move)
        break if board.out_of_bounds?(destination) ||
                 board.own_piece_at?(color, destination)

        arr << destination
        break if board.enemy_piece_at?(color, destination)
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
