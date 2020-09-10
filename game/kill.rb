class Kill

  class KillError < StandardError; end

  class InvalidKillerError < KillError
    def message
      "Killer not a valid Player"
    end
  end

  class InvalidKilledError < KillError
    def message
      "Killed not a valid Player"
    end
  end

  class InvalidWeaponError < KillError
    def message
      "Not a valid Weapon"
    end
  end

  attr_reader :killer, :killed, :weapon

  def initialize(killer, killed, weapon)
    raise InvalidKillerError unless killer.is_a? Player
    raise InvalidKilledError unless killed.is_a? Player
    raise InvalidWeaponError unless weapon.is_a? Weapon

    @killer = killer
    @killed = killed
    @weapon = weapon
  end
end