class Square
  attr_reader :rank, :file, :color
  attr_accessor :occupant, :highlighted

  def initialize(rank:, file:, color:, occupant: ' ', highlighted: false)
    @rank = rank
    @file = file
    @occupant = occupant
    @color = color
    @highlighted = highlighted
  end

  def to_s
    if highlighted == true
      "\e[30;48;5;84m#{occupant.to_s}\e[0m"
    else
      case color
      when 'light'
        "\e[30;48;5;223m#{occupant.to_s}\e[0m"
      when 'dark'
        "\e[30;48;5;3m#{occupant.to_s}\e[0m"
      end
    end
  end

  def highlight
    self.highlighted = true
  end
end
