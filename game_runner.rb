require_relative('./game.rb')
require_relative('./adjuster.rb')

class GameRunner

  def initialize(game)
    @game = game
  end

  def run_game
    puts "Welcome to Snakes and Ladders. First to square #{@game.target} wins."
    while( !@game.winner() ) do
      play_turn
    end
    puts "#{@game.winner[:name]} wins the game. Woo."
  end

  def play_turn
    puts "#{@game.current_player()[:name]}. Press Enter to roll dice."
    gets
    info = @game.play_turn(rand(1..6))
    show_turn_info (info)
  end

  def show_turn_info (turn_info)
    puts "#{turn_info[:player_name]} rolled a #{turn_info[:roll]}."
 
   if turn_info[:start_position] == turn_info[:end_position]
      puts "You rolled too far. Stay where you are until your next go."
    end



    adjustment = turn_info[:adjustment]
    if(adjustment)
      if(adjustment > 0)
        puts "Nice, you hit a ladder and move forward #{turn_info[:adjustment]}."
      else
        puts "Ooh, snake! Move back #{turn_info[:adjustment]}."
      end
    end
    puts "#{turn_info[:player_name]} is now at position #{turn_info[:end_position]}"
    puts "\n"
    # the below is added to give the person a message when they throw a 6, rather than just giving them another throw.
    if turn_info[:roll] == 6
      puts "You threw a 6 so go again."
    else
      return
    end
  end
   
end

puts "What's your name player 1?"
player_1 = gets.chomp
puts "What's your name player 2?"
player_2 = gets.chomp

adjuster = Adjuster.new({2 => 4, 8 => -1})
game = Game.new(player_1, player_2, 10, adjuster)
runner = GameRunner.new(game)
runner.run_game