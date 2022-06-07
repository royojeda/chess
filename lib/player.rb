class Player
  attr_reader :color
  attr_accessor :error

  def initialize(color:)
    @color = color
  end

  def select_piece
    puts "#{color.capitalize}, please select a piece:"
    gets.chomp
  end
end
