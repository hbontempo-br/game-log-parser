require_relative './kill'
require "test/unit"

class TestKill < Test::Unit::TestCase

  def new_valid_person
    Player.new("valid_player")
  end

  def new_valid_weapon
    w = Class.new(Weapon) do
      def get_valid_weapon_list
        ["valid_weapon"]
      end
    end
    w.new("valid_weapon")
  end

  def test_invalid_killer
    assert_raise(Kill::InvalidKillerError) { Kill.new("invalid_killer", new_valid_person, new_valid_weapon) }
  end

  def test_invalid_killed
    assert_raise(Kill::InvalidKilledError) { Kill.new(new_valid_person, "invalid_killed", new_valid_weapon) }
  end

  def test_invalid_weapon
    assert_raise(Kill::InvalidWeaponError) { Kill.new(new_valid_person, new_valid_person, "invalid_weapon") }
  end

  def test_valid_init
    kill = Kill.new(new_valid_person, new_valid_person, new_valid_weapon)
    assert_equal(kill.killer, new_valid_person)
    assert_equal(kill.killed, new_valid_person)
    assert_equal(kill.weapon, new_valid_weapon)
  end
end