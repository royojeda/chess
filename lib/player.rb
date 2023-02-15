class Player
  attr_reader :color

  def initialize(color:)
    @color = color
  end

  def select_piece
    puts "#{color.capitalize}, please select a piece:"
    give_input
  end

  def choose_destination
    puts "Choose among the possible moves: "
    give_input
  end

  private

  def give_input
    gets.chomp.chars
  end
end
