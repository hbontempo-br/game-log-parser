# frozen_string_literal: true

require './app/game/base_game/player'
require './app/game/base_game/weapon'
require './app/game/base_game/suicide'

require 'test/unit'

# Suicide test class
class SuicideTest < Test::Unit::TestCase
  # Weapon class used for the test
  class WeaponTest < Weapon
    # @return [Array<String>]
    def valid_weapon_list
      ['test_weapon']
    end
  end

  # @return [Nil]
  def test_valid_suicide_init
    player = Player.new('test_player')
    weapon = WeaponTest.new('test_weapon')
    suicide = Suicide.new(player, weapon)
    assert_equal(player, suicide.player, 'Not expected player')
    assert_equal(weapon, suicide.weapon, 'Not expected player')
  end

  # @return [Nil]
  def test_invalid_weapon_on_suicide_init
    player = Player.new('test_player')
    not_a_weapon = 'invalid_weapon'
    # noinspection RubyYardParamTypeMatch
    assert_raise(Suicide::SuicideInvalidWeaponError) { Suicide.new(player, not_a_weapon) }
  end

  # @return [Nil]
  def test_invalid_player_on_suicide_init
    not_a_player = 'invalid_player'
    weapon = WeaponTest.new('test_weapon')
    # noinspection RubyYardParamTypeMatch
    assert_raise(Suicide::SuicideInvalidPlayerError) { Suicide.new(not_a_player, weapon) }
  end
end
