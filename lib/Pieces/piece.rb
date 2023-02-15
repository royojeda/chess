class Piece
  attr_reader :color
  attr_accessor :square, :previous, :first_move

  def initialize(color:, square: nil, previous: nil, first_move: true)
    @color = color
    @square = square
    @previous = previous
    @first_move = first_move
  end

  def moved
    self.first_move = false
  end

  def all_destinations(board, for_check: false)
    arr = []
    moves.each do |direction|
      direction.each do |move|
        destination = destination_from(move)
        break if stop_before?(board, destination)

        arr << destination
        break if stop_after?(board, destination)
      end
    end
    arr + special_moves(board, for_check: for_check)
  end

  def previous_is_two_forward?
    square.rank == (previous.rank.ord + 2).chr ||
      square.rank == (previous.rank.ord - 2).chr
  end

  def location
    [square.file, square.rank]
  end

  private

  def moves
  end

  def special_moves(board, for_check: false)
    valid_specials = specials.select do |special|
      special_allowed?(special, board, for_check: for_check)
    end
    valid_specials.map { |special| destination_from(special) }
  end

  def specials
    []
  end

  def stop_before?(board, destination)
    board.out_of_bounds?(destination) || board.own_piece_at?(color, destination)
  end

  def stop_after?(board, destination)
    board.enemy_piece_at?(color, destination)
  end

  def destination_from(move)
    [destination_file(move[0]), destination_rank(move[1])]
  end

  def destination_file(horizontal_move)
    (file.ord + horizontal_move).chr
  end

  def destination_rank(vertical_move)
    (rank.ord + vertical_move).chr
  end

  def file
    square.file
  end

  def rank
    square.rank
  end

  def to_s
    case color
    when "white"
      color_white
    when "black"
      color_black
    end
  end
end
