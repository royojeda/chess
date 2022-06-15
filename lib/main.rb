require './lib/game'
# require './lib/board'

# test = Game.new
# test.play

def ask_load
  puts 'Do you want to load a saved game? (y/n): '
  load_choice = gets.chomp.downcase
  execute(load_choice)
end

def execute(load_choice)
  case load_choice
  when 'y'
    File.open('save_file') { |f| Marshal.load(f) }
  when 'n'
    Game.new
  else
    system 'clear'
    puts 'Invalid choice. Please try again.'
    ask_load
  end
end

system 'clear'
current_game = ask_load
save = current_game.play

if save == true
  File.open('save_file', 'w+') { |f| Marshal.dump(current_game, f) }

  system 'clear'
  puts "Game saved.\n\n"
end
