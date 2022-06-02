class Square
  attr_reader :rank, :file
  attr_accessor :occupant

  def initialize(rank:, file:, occupant: ' ')
    @rank = rank
    @file = file
    @occupant = occupant
  end

  def to_s
    occupant.to_s
  end
end
