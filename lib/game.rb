require './lib/board'
require './lib/player'

class Game
  attr_reader :board, :players

  def initialize(board: Board.new,
                 player_one: Player.new(color: 'white'),
                 player_two: Player.new(color: 'black'))
    @board = board
    @players = [player_one, player_two]
  end

  def current_player
    players[0]
  end

  def display
    system 'clear'
    puts current_player.error
    puts
    board.display
    puts
  end
end
