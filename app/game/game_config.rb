# frozen_string_literal: true

require_relative 'base_game/player'
require_relative 'base_game/weapon'
require_relative 'base_game/kill'
require_relative 'base_game/suicide'
require_relative 'base_game/game'

# Class that bundles all game entities
class GameConfig
  class GameConfigError < StandardError; end

  # Error received when trying to use a invalid Player in the GameConfig
  class GameConfigInvalidPlayerClass < GameConfigError
    # @return [String]
    def message
      'Invalid Player class'
    end
  end

  # Error received when trying to use a invalid Weapon in the GameConfig
  class GameConfigInvalidWeaponClass < GameConfigError
    # @return [String]
    def message
      'Invalid Weapon class'
    end
  end

  # Error received when trying to use a invalid Kill in the GameConfig
  class GameConfigInvalidKillClass < GameConfigError
    # @return [String]
    def message
      'Invalid Kill class'
    end
  end

  # Error received when trying to use a invalid Suicide in the GameConfig
  class GameConfigInvalidSuicideClass < GameConfigError
    # @return [String]
    def message
      'Invalid Suicide class'
    end
  end

  # Error received when trying to use a invalid Game in the GameConfig
  class GameConfigInvalidGameClass < GameConfigError
    # @return [String]
    def message
      'Invalid Game class'
    end
  end

  attr_reader :player_class, :weapon_class, :kill_class, :suicide_class, :game_class

  # @param player_class [Class<Player>]
  # @param weapon_class [Class<Weapon>]
  # @param kill_class [Class<Kill>]
  # @param suicide_class [Class<Suicide>]
  # @param game_class [Class<Game>]
  # @return [GameConfig]
  def initialize(player_class, weapon_class, kill_class, suicide_class, game_class)
    raise GameConfigInvalidPlayerClass unless player_class.is_a? Player.class
    raise GameConfigInvalidWeaponClass unless weapon_class.is_a? Weapon.class
    raise GameConfigInvalidKillClass unless kill_class.is_a? Kill.class
    raise GameConfigInvalidSuicideClass unless suicide_class.is_a? Suicide.class
    raise GameConfigInvalidGameClass unless game_class.is_a? Game.class

    @player_class = player_class
    @weapon_class = weapon_class
    @kill_class = kill_class
    @suicide_class = suicide_class
    @game_class = game_class
  end
end
