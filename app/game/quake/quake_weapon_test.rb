# frozen_string_literal: true

require_relative 'quake_weapon'
require 'test/unit'

# QuakeWeapon test class
class QuakeWeaponTest < Test::Unit::TestCase
  # @return [Array<String>]
  def valid_weapons
    [
        'MOD_UNKNOWN',
        'MOD_SHOTGUN',
        'MOD_GAUNTLET',
        'MOD_MACHINEGUN',
        'MOD_GRENADE',
        'MOD_GRENADE_SPLASH',
        'MOD_ROCKET',
        'MOD_ROCKET_SPLASH',
        'MOD_PLASMA',
        'MOD_PLASMA_SPLASH',
        'MOD_RAILGUN',
        'MOD_LIGHTNING',
        'MOD_BFG',
        'MOD_BFG_SPLASH',
        'MOD_WATER',
        'MOD_SLIME',
        'MOD_LAVA',
        'MOD_CRUSH',
        'MOD_TELEFRAG',
        'MOD_FALLING',
        'MOD_SUICIDE',
        'MOD_TARGET_LASER',
        'MOD_TRIGGER_HURT',
        'MOD_NAIL',
        'MOD_CHAINGUN',
        'MOD_PROXIMITY_MINE',
        'MOD_KAMIKAZE',
        'MOD_JUICED',
        'MOD_GRAPPLE'
    ]
  end

  # @return [Nil]
  def test_valid_weapon_name
    valid_weapons.each do |weapon_name|
      weapon = QuakeWeapon.new(weapon_name)
      assert_equal(weapon_name, weapon, 'Unexpected weapon')
    end
  end
end
