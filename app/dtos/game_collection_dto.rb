# frozen_string_literal: true

require_relative '../game/game_collection'
require_relative './game_dto'

class GameCollectionDTO

  class GameCollectionDTOError < StandardError; end

  # Error received when trying to initialize a GameCollectionDTO with an invalid game_collection (game should be a GameCollection)
  class InvalidGameCollectionDTOError < GameCollectionDTOError
    # @return [String]
    def message
      'Invalid game_collection'
    end
  end

  attr_reader :game_collection

  # @param game_collection [GameCollection]
  def initialize(game_collection)
    raise InvalidGameCollectionDTOError unless game_collection.is_a? GameCollection

    @game_collection = game_collection
  end

  # @return [Hash]
  def to_hash
    game_collection_hash = {}
    @game_collection.games.each_with_index do |game, index|
      game_dto = GameDTO.new(game)
      game_collection_hash['game_'+ (index+1).to_s] = game_dto.to_hash
    end
    game_collection_hash
  end

end