class Square
  attr_reader :rank, :file, :color
  attr_accessor :occupant, :status

  def initialize(rank:, file:, color:, occupant: ' ', status: '')
    @rank = rank
    @file = file
    @occupant = occupant
    @color = color
    @status = status
  end

  def to_s
    case status
    when 'selected'
      "\e[30;48;5;81m#{occupant.to_s}\e[0m"
    when 'possible_move'
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

  def selected
    self.status = 'selected'
  end

  def possible_move
    self.status = 'possible_move'
  end
end
