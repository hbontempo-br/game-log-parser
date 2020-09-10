class Weapon < String

  class WeaponError < StandardError; end

  class InvalidWeaponError < WeaponError
    def message
      "Invalid weapon, weapon's name must be a String"
    end
  end

  class WeaponNotFoundError < WeaponError
    def message
      "Weapon not found in the valid weapon's list"
    end
  end

  def initialize(name)
    raise InvalidWeaponError unless name.is_a? String
    raise WeaponNotFoundError unless get_valid_weapon_list.include? name
    super(name)
  end

  def get_valid_weapon_list
    raise NotImplementedError
  end
end
