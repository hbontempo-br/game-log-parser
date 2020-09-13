# frozen_string_literal: true

require_relative 'game'

# Class to represent a collection of Games
class GameCollection
  class GameCollectionError < StandardError; end

  # Error received when trying to add a game to a GameCollection with an invalid game (should be a Game)
  class GameCollectionInvalidGameError < StandardError
    # @return [String]
    def message
      'Invalid game'
    end
  end

  attr_reader :games

  # @return [GameCollection]
  def initialize
    @games = []
  end

  # @param game [Game]
  # @return [Array<Game>]
  def add_game(game)
    raise GameCollectionInvalidGameError unless game.is_a? Game

    @games.append(game)
  end
end
