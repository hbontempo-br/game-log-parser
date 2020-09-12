# frozen_string_literal: true

require_relative 'player'
require 'test/unit'

# Player test class
class PlayerTest < Test::Unit::TestCase
  # @return [Nil]
  def test_invalid_player_init
    # noinspection RubyYardParamTypeMatch
    assert_raise(Player::InvalidPlayerError) { Player.new(123) }
  end

  # @return [Nil]
  def test_valid_player_init
    player_name = 'name'
    player = Player.new(player_name)
    assert_equal(player_name, player, 'Unexpected player creation behaviour')
  end
end
