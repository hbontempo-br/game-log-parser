# frozen_string_literal: true

require_relative '../game/game_config'
require_relative '../game/game_collection'

# Class to represent a game log parser
class BaseLogParser
  class GameLogParserError < StandardError; end

  # Error received when trying to process a BaseLogParser with a invalid file_reader parameter (should be a Enumerator)
  class InvalidFileReaderGameLogParserError < GameLogParserError
    # @return [String]
    def message
      'Invalid file reader'
    end
  end

  # Error received when trying to initialize a BaseLogParser with a invalid game_config parameter (should be a FileConfig)
  class InvalidGameConfigGameLogParserError < GameLogParserError
    # @return [String]
    def message
      'Invalid game config'
    end
  end

  # Error received when an action is found before it's game start
  class GameNotStartedGameLogParserError < GameLogParserError
    # @return [String]
    def message
      'Cannot execute action. There is no game start'
    end
  end

  # Error received when an game start is found before the last game ending
  class GameNotFinishedGameLogParserError < GameLogParserError
    # @return [String]
    def message
      'Cannot start a game while the previous haven`t finished yet'
    end
  end

  # Internal error. Invalid state reached
  class UnexpectedGameTypeLogParserError < GameLogParserError
    # @return [String]
    def message
      'Internal Error. Current game should be nil or an instance of Game'
    end
  end

  attr_reader :game_config

  # @param game_config [GameConfig]
  # @return [BaseLogParser]
  def initialize(game_config)
    raise InvalidGameConfigGameLogParserError unless game_config.is_a? GameConfig

    @game_config = game_config
  end

  # @param record
  # @return [Boolean]
  def new_game?(record)
    raise NotImplementedError
  end

  # @param record
  # @return [Boolean]
  def game_end?(record)
    raise NotImplementedError
  end

  # @param record
  # @return [Boolean]
  def kill?(record)
    raise NotImplementedError
  end

  # @param record
  # @return [Boolean]
  def suicide?(record)
    raise NotImplementedError
  end

  # @param record
  # @return [Boolean]
  def player?(record)
    raise NotImplementedError
  end

  # @param record
  # @return [Array<String>]
  def retrieve_player_name(record)
    raise NotImplementedError
  end

  # @param record
  # @return [Array<String>]
  def retrieve_kill_info(record)
    raise NotImplementedError
  end

  # @param record
  # @return [Array<String>]
  def retrieve_suicide_info(record)
    raise NotImplementedError
  end

  # @param file_reader [Enumerator]
  # @return [GameCollection]
  def process (file_reader)
    raise InvalidFileReaderGameLogParserError unless file_reader.is_a? Enumerator

    game_collection = GameCollection.new
    current_game = nil

    # TODO: Handle better cases where there are errors (like invalidating the game)

    file_reader.each do |record|
      # TODO: Remove if-else and use a more scalable solution (like with a hashmap - getType then a processFunction[type])
      if new_game?(record)
        raise GameNotFinishedGameLogParserError unless current_game.nil?
        raise UnexpectedGameTypeLogParserError unless current_game.is_a?(Game) || current_game.nil?

        current_game = @game_config.game_class.new
      elsif game_end?(record)
        validate_active_game(current_game)

        game_collection.add_game(current_game)
        current_game = nil
      elsif player?(record)
        validate_active_game(current_game)

        player_name = retrieve_player_name(record)
        player = @game_config.player_class.new(player_name)
        current_game.add_player(player)
      elsif kill?(record)
        validate_active_game(current_game)

        killer_name, killed_name, weapon_name = retrieve_kill_info(record)
        killer = @game_config.player_class.new(killer_name)
        killed = @game_config.player_class.new(killed_name)
        weapon = @game_config.weapon_class.new(weapon_name)
        kill = @game_config.kill_class.new(killer, killed, weapon)
        current_game.add_kill(kill)
      elsif suicide?(record)
        validate_active_game(current_game)

        player_name, weapon_name = retrieve_suicide_info(record)
        player = @game_config.player_class.new(player_name)
        weapon = @game_config.weapon_class.new(weapon_name
        )
        suicide = @game_config.suicide_class.new(player, weapon)
        current_game.add_suicide(suicide)
      end
    end
    game_collection
  end

  private

  # @param current_game [Object]
  # @return [Nil]
  def validate_active_game(current_game)
    raise GameNotStartedGameLogParserError if current_game.nil?
    raise UnexpectedGameTypeLogParserError unless current_game.is_a?(Game) || current_game.nil?
  end
end
