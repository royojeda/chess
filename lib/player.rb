class Player
  attr_reader :color

  def initialize(color:)
    @color = color
  end

  def select_piece
    puts "#{color.capitalize}, please select a piece:"
    gets.chomp.chars
  end

  def choose_destination
    puts 'Choose among the possible moves: '
    gets.chomp.chars
  end
end
