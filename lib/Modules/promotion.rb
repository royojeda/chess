module Promotion
  private

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
end
