# frozen_string_literal: true

require_relative 'player'
require_relative 'weapon'
require_relative 'kill'
require_relative 'suicide'
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

  # Error received when trying to add a suicide to a Game with an invalid suicide (should be a Suicide)
  class GameInvalidSuicideError < GameError
    # @return [String]
    def message
      'Invalid Suicide'
    end
  end

  # Error received when trying to add a kill to a Game with an a player not previously added
  class GamePlayerNotInGame < GameError
    # @return [String]
    def message
      'Player involved in kill not in the game'
    end
  end

  attr_reader :players, :kills, :suicides

  # @return [Game]
  def initialize
    @players = Set.new
    @kills = []
    @suicides = []
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
    raise GamePlayerNotInGame unless @players.include?(kill.killer) && @players.include?(kill.killed)

    @kills.append(kill)
  end

  # @param suicide [Suicide]
  # @return [Array<Suicide>]
  def add_suicide(suicide)
    raise GameInvalidSuicideError unless suicide.is_a? Suicide
    raise GamePlayerNotInGame unless @players.include?(suicide.player)

    @suicides.append(suicide)
  end

  # @return [Integer]
  def total_deaths
    @suicides.length + @suicides.length
  end

  # @param player [Player]
  # @return [Integer]
  def player_kill_score(player)
    raise GameInvalidPlayerError unless player.is_a? Player
    raise GamePlayerNotInGame unless @players.include? player

    kills = 0
    @kills.each do |kill|
      kills += 1 if kill.killer == player
    end
    @suicides.each do |suicide|
      kills -= 1 if suicide.player == player
    end
    kills
  end

  # @return [Hash]
  def all_players_score
    kills_hash = {}
    @players.each do |player|
      kills_hash[player] = player_kill_score(player)
    end
    kills_hash
  end

  def player_rank
    scores = all_players_score
    rank = scores.sort_by { |player, score| score }
    rank.reverse.map { |position| position[0] }
  end
end
