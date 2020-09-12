# frozen_string_literal: true

require_relative 'player'
require_relative 'weapon'
require_relative 'kill'
require_relative 'game'
require_relative 'game_config'
require 'test/unit'

# GameConfig test class
class GameConfigTest < Test::Unit::TestCase
  # @return [Nil]
  def test_valid_game_config
    game_config = GameConfig.new(Player, Weapon, Kill, Game)
    assert_equal(Player, game_config.player_class, 'Unexpected Player class')
    assert_equal(Weapon, game_config.weapon_class, 'Unexpected Weapon class')
    assert_equal(Kill, game_config.kill_class, 'Unexpected Kill class')
    assert_equal(Game, game_config.game_class, 'Unexpected Game class')
  end

  # @return [Nil]
  def test_invalid_player
    # noinspection RubyYardParamTypeMatch
    assert_raise(GameConfig::GameConfigInvalidPlayerClass) { GameConfig.new('not a player player', Weapon, Kill, Game) }
  end

  # @return [Nil]
  def test_invalid_weapon
    # noinspection RubyYardParamTypeMatch
    assert_raise(GameConfig::GameConfigInvalidWeaponClass) { GameConfig.new(Player, 'not a weapon class', Kill, Game) }
  end

  # @return [Nil]
  def test_invalid_kill
    # noinspection RubyYardParamTypeMatch
    assert_raise(GameConfig::GameConfigInvalidKillClass) { GameConfig.new(Player, Weapon, 'not a kill class', Game) }
  end

  # @return [Nil]
  def test_invalid_game
    # noinspection RubyYardParamTypeMatch
    assert_raise(GameConfig::GameConfigInvalidGameClass) { GameConfig.new(Player, Weapon, Kill, 'not a game class') }
  end
end
