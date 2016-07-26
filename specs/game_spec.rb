require 'minitest/autorun'
require 'minitest/rg'
require_relative('../game')
require_relative('../adjuster')

class TestGame < MiniTest::Test

  def setup
    @game = Game.new("Jay", "Tony", 5)
    @adjuster = Adjuster.new({4 => 8})
    @game_with_adjuster = Game.new("Jay", "Tony", 10, @adjuster)
  end


  def test_players_start_at_position_0()
    assert_equal([
      {name: "Jay", position: 0}, 
      {name: "Tony", position: 0}
      ], @game.players()
      )
  end

  def test_can_move_player()
    @game.move_player( 0, 5 )
    assert_equal( {name: "Jay", position: 5}, @game.players[0])
  end

  def test_current_player_is_first_player_at_start()
    assert_equal({name: "Jay", position: 0}, @game.current_player())
  end

  def test_can_change_current_player()
    @game.change_current_player()
    assert_equal({name: "Tony", position: 0}, @game.current_player())
  end

  def test_can_move_current_player()
    @game.move_current_player(5)
    assert_equal({name: "Jay", position: 5}, @game.current_player())
  end

  def test_taking_turn_increases_current_player_position()
    @game.play_turn(5)
    assert_equal( {name: "Jay", position: 5}, @game.players[0])
  end

  def test_taking_turn_changes_current_player()
    @game.play_turn(5)
    assert_equal("Tony", @game.current_player[:name])
  end

  def test_taking_turn_returns_info()
    info = @game.play_turn(5)
    assert_equal({
      player_name: "Jay",
      roll: 5,
      end_position: 5
      }, info)
  end

  def test_has_target
    assert_equal(5, @game.target)
  end

  def test_can_show_winner
    @game.move_current_player(5)
    assert_equal( {name: "Jay", position: 5}, @game.winner)
  end

  def test_shows_no_winner
    assert_equal( false, @game.winner)
  end

  def test_game_will_consider_adjustment()
    info = @game_with_adjuster.play_turn(4)
    assert_equal({player_name: "Jay", roll: 4, adjustment: 8, end_position: 12}, info)
  end


end