class Square
  attr_reader :rank, :file, :occupant

  def initialize(file:, rank:, occupant: 'X')
    @file = file
    @rank = rank
    @occupant = occupant
  end
end
