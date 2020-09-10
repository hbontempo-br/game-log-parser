require_relative './player'
require "test/unit"

class PlayerTest < Test::Unit::TestCase

  def test_invalid_player_init
    assert_raise(Player::InvalidPlayerError) { Player.new(123) }
  end

  def test_valid_player_init
    player_name = "name"
    player = Player.new(player_name)
    assert_equal(player_name, player, "Unexpected player creation behaviour")
  end

end