class Game

  attr_reader :players, :target

  def initialize(player_1_name, player_2_name, target, adjuster=nil)
    # the =nil above is setting a default value so if you set up a game and don't pass in an adjuster it will just set it to be nil.
    @players = [{name: player_1_name, position: 0}, {name: player_2_name, position: 0}]
    @current_player_index = 0
    @target = target
    @adjuster = adjuster
  end

  # in the below I'm trying to make it so that if your roll will take you beyond the end square you won't get to move, so you'll need to land on it to win.
  def move_player(player_index, distance)
    player = @players[ player_index ]
    if player[:position] + distance <= @target
      player[:position] += distance
    else
      player[:position]
    end
  end
# below is the original code where you automatically move the distance whether of not it takes you beyond the end space.
  # def move_player(player_index, distance)
  #   player = @players[ player_index ]
  #   player[:position] += distance
  # end

  def current_player()
   return @players[ @current_player_index ]
  end

  def change_current_player(distance)
    # adding this check on the distance means if a player rolls a 6 then it won't change current player and you'll get to roll again.
    if distance == 6 
      return
    else
    @current_player_index = (@current_player_index + 1) % @players.length
  end
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
      start_position: current_player[:position]
    }

   
# below added in so you can go beyond the final square. If your roll would take you beyond it you won't move.
     move_current_player(distance) if info[:roll] + current_player[:position] <= 10

    if @adjuster
      adjustment = @adjuster.adjustment(current_player()[:position])
      move_current_player(adjustment) if adjustment
      info[:adjustment] = adjustment
    end
# above we are adding in a way to adjust in case the place you move to has a snake or a ladder. We're going to call the adjuster and check if it has any adjustments to make if a player lands on a particular space.
    info[:end_position] = current_player[:position]
    change_current_player(distance)
    return info
  end
# originally had >= target but taken that out as we're now playing a version where you have to land on the final square, not land on it or go past it.
  def winner
    for player in @players
      return player if player[:position] == target
    end
      return false
    # if current_player[:position] >= @target
    #   return current_player
    # else
    #   return false
    # end 
  end
end