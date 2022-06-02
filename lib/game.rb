class Game
  attr_reader :board, :players

  def initialize(board: Board.new, players: [Player.new(color: 'white'), Player.new(color: 'black')])
    @board = board
    @players = players
  end

  def current_player
    players[0]
  end

  def display
    system 'clear'
    puts current_player.error
    puts
    puts board
    puts
  end

  def turn
    display
    start = current_player.select_square
    board.check_start(current_player, start)
    display
  end
end
