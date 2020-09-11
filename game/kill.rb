# frozen_string_literal: true

require_relative 'player'
require_relative 'weapon'

# Class to represent a Game's Kill
class Kill
  class KillError < StandardError; end

  # Error received when trying to initialize a Kill with a invalid killer parameter (should be a Player)
  class InvalidKillerError < KillError
    # @return [String]
    def message
      'Killer not a valid Player'
    end
  end

  # Error received when trying to initialize a Kill with a invalid killed parameter (should be a Player)
  class InvalidKilledError < KillError
    # @return [String]
    def message
      'Killed not a valid Player'
    end
  end

  # Error received when trying to initialize a Kill with a invalid weapon parameter (should be a Weapon)
  class InvalidWeaponError < KillError
    # @return [String]
    def message
      'Not a valid Weapon'
    end
  end

  attr_reader :killer, :killed, :weapon

  # @param killer [Player] killer player
  # @param killed [Player] killed player
  # @param weapon [Weapon] weapon used
  # @return [Kill]
  def initialize(killer, killed, weapon)
    raise InvalidKillerError unless killer.is_a? Player
    raise InvalidKilledError unless killed.is_a? Player
    raise InvalidWeaponError unless weapon.is_a? Weapon

    @killer = killer
    @killed = killed
    @weapon = weapon
  end
end
