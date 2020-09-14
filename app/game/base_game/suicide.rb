# frozen_string_literal: true

require_relative 'player'
require_relative 'weapon'

# Class to represent a Suicide in game
class Suicide
  class SuicideError < StandardError; end

  # Error received when trying to initialize a Suicide with an invalid player parameter (should be a Player)
  class SuicideInvalidPlayerError < SuicideError
    # @return [String]
    def message
      'Invalid player'
    end
  end

  # Error received when trying to initialize a Suicide with an invalid weapon parameter (should be a Weapon)
  class SuicideInvalidWeaponError < SuicideError
    # @return [String]
    def message
      'Invalid weapon'
    end
  end

  attr_reader :player, :weapon

  # @param player [Player]
  # @param weapon [Weapon]
  # @return [Suicide]
  def initialize(player, weapon)
    raise SuicideInvalidPlayerError unless player.is_a? Player
    raise SuicideInvalidWeaponError unless weapon.is_a? Weapon

    @player = player
    @weapon = weapon
  end
end
