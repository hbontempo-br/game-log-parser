# frozen_string_literal: true

require_relative '../game/base_game/game'

class GameDTO
  class GameDTOError < StandardError; end

  # Error received when trying to initialize a GameDTO with an invalid game (game should be a Game)
  class InvalidGameGameDTOError < GameDTOError
    # @return [String]
    def message
      'Invalid game'
    end
  end

  attr_reader :game

  # @param game [Game]
  def initialize(game)
    raise InvalidGameGameDTOError unless game.is_a? Game

    @game = game
  end

  # @return [Hash]
  def to_hash
    kills_hash = {}
    @game.players.each do |player|
      kills_hash[player] = @game.player_kill_score(player)
    end

    game_hash = {}
    game_hash['total_kills'] = @game.total_deaths
    game_hash['players'] = @game.players.to_a
    game_hash['kills'] = kills_hash
    game_hash
  end
end
