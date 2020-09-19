# frozen_string_literal: true

require_relative 'base_log_parser'
require_relative '../game/quake/quake_player'
require_relative '../game/quake/quake_weapon'
require_relative '../game/quake/quake_kill'
require_relative '../game/quake/quake_suicide'
require_relative '../game/quake/quake_game'

# Class to represent a Quake log parser
class QuakeLogParser < BaseLogParser
  class QuakeLogParserError < StandardError; end

  # Error received when trying to process an invalid log with QuakeLogParser
  class InvalidRecordTypeQuakeLogParserError < QuakeLogParserError
    # @return [String]
    def message
      'The reported record is not and valid Quake log record'
    end
  end

  # @param game_config [GameConfig]
  # @return [QuakeLogParser]
  def initialize(game_config = GameConfig.new(QuakePlayer, QuakeWeapon, QuakeKill, QuakeSuicide, QuakeGame))
    super(game_config)
  end

  # @param record [String]
  # @return [Boolean]
  def new_game?(record)
    raise InvalidRecordTypeQuakeLogParserError unless record.is_a? String

    record[7, 8] == 'InitGame'
  end

  # @param record [String]
  # @return [Boolean]
  def game_end?(record)
    raise InvalidRecordTypeQuakeLogParserError unless record.is_a? String

    record[7, 12] == 'ShutdownGame'
  end

  # @param record [String]
  # @return [Boolean]
  def kill?(record)
    raise InvalidRecordTypeQuakeLogParserError unless record.is_a? String

    record[7, 4] == 'Kill' && get_killer(record) != '<world>'
  end

  # @param record [String]
  # @return [Boolean]
  def suicide?(record)
    raise InvalidRecordTypeQuakeLogParserError unless record.is_a? String
    return false if record.length < 12

    record[7, 4] == 'Kill' && get_killer(record) == '<world>'
  end

  # @param record [String]
  # @return [Boolean]
  def player?(record)
    raise InvalidRecordTypeQuakeLogParserError unless record.is_a? String

    record[7, 21] == 'ClientUserinfoChanged'
  end

  # @param record [String]
  # @return [String]
  def retrieve_player_name(record)

    record[34..].split('\t')[0]
  end

  # @param record [String]
  # @return [Array<String>]
  def retrieve_kill_info(record)
    weapon = record.split.last
    killer = get_killer(record)
    killed = get_killed(record)

    [killer, killed, weapon]
  end

  # @param record [String]
  # @return [Array<String>]
  def retrieve_suicide_info(record)
    weapon = record.split.last
    player_name = get_killed(record)

    [player_name, weapon]
  end

  private

  # @param record [String]
  # @return [String]
  def get_killer(record)

    between(record[14..], ': ', ' killed')
  end

  # @param record [String]
  # @return [String]
  def get_killed(record)

    between(record[14..], 'killed ', ' by')
  end

  # @param original_string [String]
  # @param start_string [String]
  # @param end_string [String]
  # @return [String]
  def between(original_string, start_string, end_string)
    unless original_string.is_a?(String) && start_string.is_a?(String) && end_string.is_a?(String)
      raise InvalidRecordTypeQuakeLogParserError
    end

    intermediate_cut = original_string[/#{start_string}(.*?)#{end_string}/m]

    if intermediate_cut.nil? || intermediate_cut.length < (start_string.length + end_string.length)
      raise InvalidRecordTypeQuakeLogParserError
    end

    intermediate_cut[start_string.length..-end_string.length - 1].to_s
  end
end
