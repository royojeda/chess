require './lib/board'

system 'clear'
test = Board.new
test.square_in(['e', '2']).highlight
puts test
