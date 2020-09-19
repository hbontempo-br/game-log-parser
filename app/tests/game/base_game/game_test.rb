# frozen_string_literal: true

require './app/game/base_game/player'
require './app/game/base_game/weapon'
require './app/game/base_game/kill'
require './app/game/base_game/suicide'
require './app/game/base_game/game'
require 'test/unit'

require 'set'

# Game test class
class GameTest < Test::Unit::TestCase
  # Weapon class used for the test
  class WeaponTest < Weapon
    # @return [Array<String>]
    def valid_weapon_list
      %w[test_weapon test_weapon2]
    end
  end

  # @param killer_name [String]
  # @param killed_name [String]
  # @return [Kill]
  def new_valid_kill(killer_name, killed_name)
    killer = Player.new(killer_name)
    killed = Player.new(killed_name)
    weapon = WeaponTest.new('test_weapon')
    Kill.new(killer, killed, weapon)
  end

  # @param player_name [String]
  # @return [Suicide]
  def new_valid_suicide(player_name)
    player = Player.new(player_name)
    weapon = WeaponTest.new('test_weapon')
    Suicide.new(player, weapon)
  end

  # @return [Nil]
  def setup
    @game = Game.new
  end

  # @return [Nil]
  def test_new_game
    assert_empty(@game.players, 'Players should be initialized empty')
    assert_empty(@game.kills, 'Kills should be initialized empty')
  end

  # @return [Nil]
  def test_add_invalid_players
    player = 'not a player'
    # noinspection RubyYardParamTypeMatch
    assert_raise(Game::GameInvalidPlayerError) { @game.add_player(player) }
  end

  # @return [Nil]
  def test_add_valid_player
    p1 = Player.new('p1')
    @game.add_player(p1)
    assert_equal(Set.new << p1, @game.players, 'Unexpected players result')
  end

  # @return [Nil]
  def test_add_duplicated_player
    player_name = 'p1'
    p1 = Player.new(player_name)
    p1_duplicated = Player.new(player_name)
    @game.add_player(p1)
    @game.add_player(p1_duplicated)
    assert_equal(Set.new << p1, @game.players, 'Unexpected players result')
    assert_equal(Set.new << p1_duplicated, @game.players, 'Unexpected players result')
  end

  # @return [Nil]
  def test_add_valid_kill
    killer = 'killer'
    killed = 'killed'
    @game.add_player(Player.new(killer))
    @game.add_player(Player.new(killed))
    kill = new_valid_kill(killer, killed)
    @game.add_kill(kill)
    assert_equal(1, @game.kills.length, 'Expected only one kill')
    assert_equal(kill, @game.kills[0], 'Unexpected kill')
  end

  # @return [Nil]
  def test_add_invalid_kill
    # noinspection RubyYardParamTypeMatch
    assert_raise(Game::GameInvalidKillError) { @game.add_kill('Not a kill') }
  end

  # @return [Nil]
  def test_add_valid_kill_with_player_not_in_game
    killer = 'killer'
    killed = 'killed'
    kill = new_valid_kill(killer, killed)
    assert_raise(Game::GamePlayerNotInGame) { @game.add_kill(kill) }
  end

  # @return [Nil]
  def test_add_valid_suicide
    player_name = 'player'
    @game.add_player(Player.new(player_name))
    suicide = new_valid_suicide(player_name)
    @game.add_suicide(suicide)
    assert_equal(1, @game.suicides.length, 'Expected only one suicide')
    assert_equal(suicide, @game.suicides[0], 'Unexpected suicide')
  end

  # @return [Nil]
  def test_add_invalid_suicide
    # noinspection RubyYardParamTypeMatch
    assert_raise(Game::GameInvalidSuicideError) { @game.add_suicide('Not a suicide') }
  end

  # @return [Nil]
  def test_add_valid_suicide_with_player_not_in_game
    player_name = 'player'
    suicide = new_valid_suicide(player_name)
    assert_raise(Game::GamePlayerNotInGame) { @game.add_suicide(suicide) }
  end

  # @return [Nil]
  def test_valid_total_deaths
    killer = 'killer'
    killed = 'killed'
    @game.add_player(Player.new(killer))
    @game.add_player(Player.new(killed))
    kill = new_valid_kill(killer, killed)
    @game.add_kill(kill)
    player_name = 'player'
    @game.add_player(Player.new(player_name))
    suicide = new_valid_suicide(player_name)
    @game.add_suicide(suicide)

    assert_equal(2, @game.total_deaths, 'Expected a total_deaths of 2 (1 kill + 1 suicide)')
  end

  # @return [Nil]
  def test_valid_player_kill_score
    killer_name = 'killer'
    killer = Player.new(killer_name)
    @game.add_player(killer)
    killed_name= 'killed'
    killed = Player.new(killed_name)
    @game.add_player(killed)
    kill = new_valid_kill(killer, killed)
    @game.add_kill(kill)
    player_name = 'player'
    suicide_player = Player.new(player_name)
    @game.add_player(suicide_player)
    suicide = new_valid_suicide(player_name)
    @game.add_suicide(suicide)

    assert_equal(1, @game.player_kill_score(killer), 'killer should have a score = 1')
    assert_equal(0, @game.player_kill_score(killed), 'killer should have a score = 0')
    assert_equal(-1, @game.player_kill_score(suicide_player), 'killer should have a score = -1')
  end

  # @return [Nil]
  def test_invalid_player_in_player_kill_score
    assert_raise(Game::GameInvalidPlayerError) { @game.player_kill_score('Not a player') }
  end

  # @return [Nil]
  def test_player_not_in_game_at_player_kill_score
    assert_raise(Game::GamePlayerNotInGame) { @game.player_kill_score(Player.new('Player not in game')) }
  end


end
