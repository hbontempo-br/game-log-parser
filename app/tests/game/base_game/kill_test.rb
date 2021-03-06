# frozen_string_literal: true

require './app/game/base_game/player'
require './app/game/base_game/weapon'
require './app/game/base_game/kill'
require 'test/unit'

# Kill test class
class TestKill < Test::Unit::TestCase
  # Weapon class used for the test
  class WeaponTest < Weapon
    # @return [Array<String>]
    def valid_weapon_list
      ['test_weapon']
    end
  end

  # @return [Player]
  def new_valid_person
    Player.new('valid_player')
  end

  # @return [Weapon]
  def new_valid_weapon
    WeaponTest.new('test_weapon')
  end

  # @return [nil]
  def test_invalid_killer
    # noinspection RubyYardParamTypeMatch
    assert_raise(Kill::InvalidKillerError) { Kill.new('invalid_killer', new_valid_person, new_valid_weapon) }
  end

  # @return [nil]
  def test_invalid_killed
    # noinspection RubyYardParamTypeMatch
    assert_raise(Kill::InvalidKilledError) { Kill.new(new_valid_person, 'invalid_killed', new_valid_weapon) }
  end

  # @return [nil]
  def test_invalid_weapon
    # noinspection RubyYardParamTypeMatch
    assert_raise(Kill::InvalidWeaponError) { Kill.new(new_valid_person, new_valid_person, 'invalid_weapon') }
  end

  # @return [nil]
  def test_valid_init
    kill = Kill.new(new_valid_person, new_valid_person, new_valid_weapon)
    assert_equal(kill.killer, new_valid_person)
    assert_equal(kill.killed, new_valid_person)
    assert_equal(kill.weapon, new_valid_weapon)
  end
end
