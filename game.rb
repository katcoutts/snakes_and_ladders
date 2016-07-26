class Game

  attr_reader :players, :target

  def initialize(player_1_name, player_2_name, target, adjuster=nil)
    # the =nil above is setting a default value so if you set up a game and don't pass in an adjuster it will just set it to be nil.
    @players = [{name: player_1_name, position: 0}, {name: player_2_name, position: 0}]
    @current_player_index = 0
    @target = target
    @adjuster = adjuster
  end

  def move_player(player_index, distance)
    player = @players[ player_index ]
    player[:position] += distance
  end

  def current_player()
   return @players[ @current_player_index ]
  end

  def change_current_player()
    @current_player_index = (@current_player_index + 1) % @players.length
# below was the initial basic way to toggle between two players but that was limited to only working for two players. Above way is more flexible.
    # if @current_player_index == 1 
    #    @current_player_index = 0
    # else
    #   @current_player_index = 1
    # end
  end

  def move_current_player(distance)
    move_player( @current_player_index, distance )
  end

  def play_turn(distance)
    info = {
      player_name: current_player[:name],
      roll: distance, 
    }
    move_current_player(distance)

    if @adjuster
      adjustment = @adjuster.adjustment(current_player()[:position])
      move_current_player(adjustment) if adjustment
      info[:adjustment] = adjustment
    end
# above we are adding in a way to adjust in case the place you move to has a snake or a ladder. We're going to call the adjuster and check if it has any adjustments to make if a player lands on a particular space.
    info[:end_position] = current_player[:position]
    change_current_player()
    return info
  end

  def winner
    for player in @players
      return player if player[:position] >= target
    end
      return false
    # if current_player[:position] >= @target
    #   return current_player
    # else
    #   return false
    # end 
  end
end