class Square
  attr_reader :rank, :file, :occupant, :status, :color

  def initialize(file:, rank:, occupant: ' ', status: '')
    @file = file
    @rank = rank
    @occupant = occupant
    @status = status
    @color = determine_color
  end

  def determine_color
    if file_and_rank_odd? || file_and_rank_even?
      color_dark
    else
      color_light
    end
  end

  def color_dark
    'dark'
  end

  def color_light
    'light'
  end

  def file_and_rank_odd?
    file.ord.odd? && rank.to_i.odd?
  end

  def file_and_rank_even?
    file.ord.even? && rank.to_i.even?
  end

  def to_s
    "\e[30;48;5;#{background_color}m#{occupant}\e[0m"
  end

  def background_color
    case status
    when 'blue'
      background_blue
    when 'green'
      background_green
    else
      normal_color
    end
  end

  def normal_color
    case color
    when 'light'
      background_light
    when 'dark'
      background_dark
    end
  end

  def background_blue
    81
  end

  def background_green
    84
  end

  def background_light
    223
  end

  def background_dark
    3
  end
end
