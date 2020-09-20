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
    {
        total_kills: @game.total_deaths,
        players: @game.players.to_a,
        kills: @game.all_players_score,
        rank: formatted_rank,
        kills_by_means: @game.all_weapons_kill_score,
        is_valid: @game.is_valid
    }
  end

  private

  # @return [Hash]
  def formatted_rank
    rank_map = {}
    @game.player_rank.each_with_index do |item, index|
      rank_map[(index + 1).to_s] = item
    end
    rank_map
  end
end
