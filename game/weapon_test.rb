require_relative 'weapon'
require "test/unit"

class WeaponTest < Test::Unit::TestCase

  def get_new_weapon_class
    Class.new(Weapon) do
      def get_valid_weapon_list
        ["test_weapon"]
      end
    end
  end

  def test_invalid_weapon_init
    assert_raise(Weapon::InvalidWeaponError) { Weapon.new(123) }
  end

  def test_weapon_init_without_valid_weapon_list
    assert_raise(NotImplementedError) { Weapon.new("weapon1") }
  end

  def test_valid_weapon_init
    test_class = get_new_weapon_class
    weapon = test_class.new("test_weapon")
    assert_equal("test_weapon", weapon, "Error on weapon creation")
  end

  def test_weapon_not_in_valid_list
    test_class = get_new_weapon_class
    assert_raise(Weapon::WeaponNotFoundError) { test_class.new("invalid_weapon") }
  end

end