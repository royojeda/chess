class Square
  attr_reader :rank, :file, :occupant

  def initialize(rank:, file:, occupant: nil)
    @rank = rank
    @file = file
    @occupant = occupant
  end

  def to_s
    "#{[file, rank, occupant]}"
  end
end
