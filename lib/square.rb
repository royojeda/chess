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

  def check_for_errors_by(player)
    player.error = if occupant == ' '
                     'That location does not contain one of your pieces.'
                   elsif occupant.color != player.color
                     'That piece does not belong to you.'
                   else
                     ''
                   end
  end

  def possible_fin
    occupant.moves.map do |move|
      [(file.ord + move[0]).chr, (rank.ord + move[1]).chr]
    end
  end
end
