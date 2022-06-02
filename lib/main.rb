require './lib/board'
require './lib/player'

system 'clear'
player = Player.new(color: 'white')
puts board = Board.new
start = player.select_square
board.square_in(start).select_as_start
system 'clear'
puts board
