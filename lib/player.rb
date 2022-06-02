class Player
  attr_reader :color
  attr_accessor :error

  def initialize(color:, error: nil)
    @color = color
    @error = error
  end

  def select_square
    loop do
      puts 'Please enter the location of the piece you want to move: '
      input = give_input
      return input.chars if valid_format?(input)
    end
  end

  def give_input
    gets.chomp.downcase
  end

  def valid_format?(input)
    input.match?(/^[a-h][1-8]$/)
  end
end
