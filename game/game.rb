# frozen_string_literal: true

require_relative 'player'
require_relative 'weapon'
require_relative 'kill'
require 'set'

# Class to represent a Game
class Game
  class GameError < StandardError; end

  # Error received when trying to add a player to a Game with an invalid player (should be a Player)
  class GameInvalidPlayerError < GameError
    # @return [String]
    def message
      'Invalid Player'
    end
  end

  # Error received when trying to add a kill to a Game with an invalid kill (should be a Kill)
  class GameInvalidKillError < GameError
    # @return [String]
    def message
      'Invalid Kill'
    end
  end

  # Error received when trying to add a kill to a Game with an a player not previously added
  class GameKillPlayerNotInGame < GameError
    # @return [String]
    def message
      'Player involved in kill not in the game'
    end
  end

  attr_reader :players, :kills

  # @return [Game]
  def initialize
    @players = Set.new
    @kills = []
  end

  # @param player [Player]
  # @return [Set<Player>]
  def add_player(player)
    raise GameInvalidPlayerError unless player.is_a? Player

    @players << player
  end

  # @param kill [Kill]
  # @return [Array<Kill>]
  def add_kill(kill)
    raise GameInvalidKillError unless kill.is_a? Kill
    raise GameKillPlayerNotInGame unless @players.include?(kill.killer) && @players.include?(kill.killed)

    @kills.append(kill)
  end
end
