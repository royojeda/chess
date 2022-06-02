require './lib/board'
require './lib/player'

system 'clear'
player = Player.new(color: 'white')
puts board = Board.new
start = player.select_square
board.square_in(start).status_selected
board.square_in(['e', '3']).status_possible_move
board.square_in(['e', '4']).status_possible_move
system 'clear'
puts board
