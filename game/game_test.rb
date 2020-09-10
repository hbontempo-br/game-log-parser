require_relative './game'
require "test/unit"

require 'set'

class GameTest < Test::Unit::TestCase

  def new_valid_kill(killer, killed)
    killer = Player.new(killer)
    killed = Player.new(killed)
    weapon_class = Class.new(Weapon) do
      def get_valid_weapon_list
        ["valid_weapon"]
      end
    end
    weapon = weapon_class.new("valid_weapon")
    Kill.new(killer, killed, weapon)
  end

  def setup
    @game = Game.new
  end

  def test_new_game
    assert_empty(@game.players, "Players should be initialized empty")
    assert_empty(@game.kills, "Kills should be initialized empty")
  end

  def test_add_invalid_players
    player = "not a player"
    assert_raise(Game::GameInvalidPlayerError) { @game.add_player(player) }
  end

  def test_add_valid_player
    p1 = Player.new("p1")
    @game.add_player(p1)
    assert_equal(Set.new << p1, @game.players, "Unexpected players result")
  end

  def test_add_duplicated_player
    player_name = "p1"
    p1 = Player.new(player_name)
    p1_duplicated = Player.new(player_name)
    @game.add_player(p1)
    @game.add_player(p1_duplicated)
    assert_equal(Set.new << p1, @game.players, "Unexpected players result")
    assert_equal(Set.new << p1_duplicated, @game.players, "Unexpected players result")
  end

  def test_add_valid_kill
    killer = "killer"
    killed = "killed"
    @game.add_player(Player.new(killer))
    @game.add_player(Player.new(killed))
    kill = new_valid_kill(killer, killed)
    @game.add_kill(kill)
    assert_equal(1, @game.kills.length, "Expected only one kill")
    assert_equal(kill, @game.kills[0], "Unexpeted kill")
  end

  def test_add_invalid_kill
    assert_raise(Game::GameInvalidKillError) { @game.add_kill("Not a kill") }
  end

  def test_add_valid_kill_with_player_not_in_game
    killer = "killer"
    killed = "killed"
    kill = new_valid_kill(killer, killed)
    assert_raise(Game::GameKillPlayerNotInGame) { @game.add_kill(kill) }
  end

end