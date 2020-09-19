# frozen_string_literal: true

require './app/game/base_game/game'
require './app/game/game_collection'
require 'test/unit'

# GameConfig test class
class GameConfigTest < Test::Unit::TestCase
  # @return [Nil]
  def test_valid_game_inclusion
    gc = GameCollection.new
    assert_equal(0, gc.games.length, 'A GameCollection should not have a game upon creation')
    gc.add_game(Game.new)
    assert_equal(1, gc.games.length, 'Only on2 game expected')
  end
end
