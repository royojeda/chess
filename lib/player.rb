class Player
  attr_reader :error

  def initialize(color:, error: nil)
    @color = color
    @error = error
  end
end
