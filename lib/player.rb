class Player
  def initialize(color:)
    @color = color
  end

  def select_square
    loop do
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
