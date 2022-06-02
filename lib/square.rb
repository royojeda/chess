class Square
  attr_reader :rank, :file, :color
  attr_accessor :occupant, :selected

  def initialize(rank:, file:, color:, occupant: ' ', selected: false)
    @rank = rank
    @file = file
    @occupant = occupant
    @color = color
    @selected = selected
  end

  def to_s
    if selected == true
      "\e[30;48;5;81m#{occupant.to_s}\e[0m"
    else
      case color
      when 'light'
        "\e[30;48;5;223m#{occupant.to_s}\e[0m"
      when 'dark'
        "\e[30;48;5;3m#{occupant.to_s}\e[0m"
      end
    end
  end

  def select_as_start
    self.selected = true
  end
end
