require_relative 'player'
require_relative 'weapon'
require_relative 'kill'
require_relative 'game'

class GameConfig

  class GameConfigError < StandardError; end

  class GameConfigInvalidPlayerClass < GameConfigError
    # @return [String]
    def message
      'Invalid Player class'
    end
  end

  class GameConfigInvalidWeaponClass < GameConfigError
    # @return [String]
    def message
      'Invalid Weapon class'
    end
  end

  class GameConfigInvalidKillClass < GameConfigError
    # @return [String]
    def message
      'Invalid Kill class'
    end
  end

  class GameConfigInvalidGameClass < GameConfigError
    # @return [String]
    def message
      'Invalid Game class'
    end
  end

  attr_reader :player_class, :weapon_class, :kill_class, :game_class

  # @param player_class [Class<Player>]
  # @param weapon_class [Class<Weapon>]
  # @param kill_class [Class<Kill>]
  # @param game_class [Class<Game>]
  # @return [GameConfig]
  def initialize(player_class, weapon_class, kill_class, game_class)
    raise GameConfigInvalidPlayerClass unless player_class.is_a? Player.class
    raise GameConfigInvalidWeaponClass unless weapon_class.is_a? Weapon.class
    raise GameConfigInvalidKillClass unless kill_class.is_a? Kill.class
    raise GameConfigInvalidGameClass unless game_class.is_a? Game.class

    @player_class = player_class
    @weapon_class = weapon_class
    @kill_class = kill_class
    @game_class = game_class
  end
end
