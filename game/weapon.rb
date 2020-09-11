# frozen_string_literal: true

# Class to represent a Game's Weapon
class Weapon < String
  class WeaponError < StandardError; end

  # Error received when trying to initialize a Weapon with a invalid parameter (not s String)
  class InvalidWeaponError < WeaponError
    # @return [String]
    def message
      "Invalid weapon, weapon's name must be a String"
    end
  end

  # Error received when trying to initialize a Weapon not in the valid valid list
  class WeaponNotFoundError < WeaponError
    # @return [String]
    def message
      "Weapon not found in the valid weapon's list"
    end
  end

  # @param name [String] Weapon's name
  # @return [Weapon]
  def initialize(name)
    raise InvalidWeaponError unless name.is_a? String

    puts valid_weapon_list
    raise WeaponNotFoundError unless valid_weapon_list.include? name

    super(name)
  end

  # @return [Array<String>]
  def valid_weapon_list
    raise NotImplementedError
  end
end
