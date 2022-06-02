class Square
  attr_reader :rank, :file, :color
  attr_accessor :occupant

  def initialize(rank:, file:, occupant: ' ', color:)
    @rank = rank
    @file = file
    @occupant = occupant
    @color = color
  end

  def to_s
    case color
    when 'light'
      "\e[30;48;5;223m#{occupant.to_s}\e[0m"
    when 'dark'
      "\e[30;48;5;3m#{occupant.to_s}\e[0m"
    end
  end
end
