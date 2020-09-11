require_relative 'weapon'
require 'test/unit'

class WeaponTest < Test::Unit::TestCase

  class WeaponTest < Weapon
    # @return [Array<String>]
    def valid_weapon_list
      ['test_weapon']
    end
  end

  # @return [Nil]
  def test_invalid_weapon_init
    assert_raise(Weapon::InvalidWeaponError) { Weapon.new(123) }
  end

  # @return [Nil]
  def test_weapon_init_without_valid_weapon_list
    assert_raise(NotImplementedError) { Weapon.new('weapon1') }
  end

  # @return [Nil]
  def test_valid_weapon_init
    weapon = WeaponTest.new('test_weapon')
    assert_equal('test_weapon', weapon, 'Error on weapon creation')
  end

  # @return [Nil]
  def test_weapon_not_in_valid_list
    assert_raise(Weapon::WeaponNotFoundError) { WeaponTest.new('invalid_weapon') }
  end

end