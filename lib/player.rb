class Player
  attr_reader :color
  attr_accessor :error, :move

  def initialize(color:, error: nil, move: nil)
    @color = color
    @error = error
    @move = move
  end

  def make_move
    self.move = prompt
  end

  def prompt
    puts "#{color.capitalize}, please select a piece:"
    gets.chomp
  end
end
