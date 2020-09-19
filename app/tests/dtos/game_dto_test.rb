# frozen_string_literal: true

require './app/dtos/game_dto'

require 'test/unit'

# GameDTO test class
class GameDTOTest < Test::Unit::TestCase
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
    @game.add_player(killer = Player.new('killer'))
    @game.add_player(killed = Player.new('killed'))
    @game.add_kill(kill = new_valid_kill(killer, killed))
    player_name = 'player'
    suicide_player = Player.new('player')
    @game.add_player(suicide_player)
    @game.add_suicide(new_valid_suicide(player_name))
  end

  # @return [Nil]
  def test_valid_dto_init
    game_dto = GameDTO.new(@game)
    assert_equal(@game, game_dto.game, 'Unexpected game in DTO')
  end

  # @return [Nil]
  def test_invalid_dto_init
    assert_raise(GameDTO::InvalidGameGameDTOError) { GameDTO.new('Not a Game') }
  end

  # @return [Nil]
  def test_hash
    game_dto = GameDTO.new(@game)
    game_dto_hash = game_dto.to_hash
    expected_hash = {
      'total_kills' => 2,
      'players' => %w[killer killed player],
      'kills' => {
        'killer' => 1,
        'killed' => 0,
        'player' => -1
      }
    }
    assert_equal(expected_hash, game_dto_hash, 'Invalid hash generated')
  end
end

