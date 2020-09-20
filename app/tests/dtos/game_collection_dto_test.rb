# frozen_string_literal: true
#
require './app/game/base_game/player'
require './app/game/base_game/weapon'
require './app/game/base_game/kill'
require './app/game/base_game/suicide'
require './app/game/base_game/game'
require './app/game/game_collection'
require './app/dtos/game_collection_dto'

require 'test/unit'

# GameCollectionDTO test class
class GameCollectionDTOTest < Test::Unit::TestCase
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
    @game_collection = GameCollection.new
    @game_collection.add_game(@game)
    @game_collection.add_game(@game)
  end

  # @return [Nil]
  def test_valid_dto_init
    game_collection_dto = GameCollectionDTO.new(@game_collection)
    assert_equal(@game_collection, game_collection_dto.game_collection, 'Unexpected game_collection in DTO')
  end

  # @return [Nil]
  def test_invalid_dto_init
    assert_raise(GameCollectionDTO::InvalidGameCollectionDTOError) { GameCollectionDTO.new('Not a Game') }
  end

  # @return [Nil]
  def test_hash
    game_collection_dto = GameCollectionDTO.new(@game_collection)
    game_collection_dto_hash = game_collection_dto.to_hash
    expected_game_hash = {
        total_kills: 2,
        players: %w[killer killed player],
        kills: {
            'killer' => 1,
            'killed' => 0,
            'player' => -1
        }
    }
    expected_hash = {
      'game_1' => expected_game_hash,
      'game_2' => expected_game_hash
    }
    assert_equal(expected_hash, game_collection_dto_hash, 'Invalid hash generated')
  end
end

