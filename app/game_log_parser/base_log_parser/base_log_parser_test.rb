# frozen_string_literal: true

require_relative '../../game/base_game/player'
require_relative '../../game/base_game/weapon'
require_relative '../../game/base_game/kill'
require_relative '../../game/base_game/suicide'
require_relative '../../game/base_game/game'
require_relative '../../game/game_config'

require_relative 'base_log_parser'

require 'test/unit'

# BaseLogParser test class
class BaseLogParserTest < Test::Unit::TestCase

  # Infinity enumerator just used for tests
  class EnumeratorTest < Enumerator
    attr_reader :response_list
    def initialize(response_list)
      @response_list = response_list
      super
    end
    def each
      @response_list.each do |i|
        yield i
      end
    end
  end

  def valid_log_parser
    game_config = GameConfig.new(Player, Weapon, Kill, Suicide, Game)
    BaseLogParser.new(game_config)
  end
  
  # @return [Nil]
  def test_valid_initialize
    game_config = GameConfig.new(Player, Weapon, Kill, Suicide, Game)
    log_parser = BaseLogParser.new(game_config)
    assert_equal(game_config, log_parser.game_config,'Unexpected game_config')
  end

  # @return [Nil]
  def test_invalid_initialize
    assert_raise(BaseLogParser::InvalidGameConfigGameLogParserError) {BaseLogParser.new('Not a GameConfig')}
  end

  def test_new_game?
    log_parser = valid_log_parser
    assert_raise(NotImplementedError) {log_parser.new_game?('whatever')}
  end

  def test_game_end?
  log_parser = valid_log_parser
  assert_raise(NotImplementedError) {log_parser.game_end?('whatever')}
  end

  def test_kill?
    log_parser = valid_log_parser
    assert_raise(NotImplementedError) {log_parser.kill?('whatever')}
  end

  def test_suicide?
    log_parser = valid_log_parser
    assert_raise(NotImplementedError) {log_parser.suicide?('whatever')}
  end

  def test_player?
    log_parser = valid_log_parser
    assert_raise(NotImplementedError) {log_parser.player?('whatever')}
  end

  def test_retrieve_player_name
    log_parser = valid_log_parser
    assert_raise(NotImplementedError) {log_parser.retrieve_player_name('whatever')}
  end

  def test_retrieve_kill_info
    log_parser = valid_log_parser
    assert_raise(NotImplementedError) {log_parser.retrieve_kill_info('whatever')}
  end

  def test_retrieve_suicide_info
    log_parser = valid_log_parser
    assert_raise(NotImplementedError) {log_parser.retrieve_suicide_info('whatever')}
  end

  def test_invalid_process
    log_parser = valid_log_parser
    assert_raise(BaseLogParser::InvalidFileReaderGameLogParserError) do
      log_parser.process('Not and enumerator')
    end
  end

  # TODO: how to test a case where UnexpectedGameTypeLogParserError is thrown?
  #       Maybe breaking game creation to a separate method derive a class witch returns an invalid game

  # TODO: Add tests for process method. All forks should be checked

  # def test_process_no_fork
  #   log_parser = valid_log_parser
  #   def log_parser.new_game?(record); false end
  #   def log_parser.game_end?(record); false end
  #   def log_parser.player?(record); false end
  #   def log_parser.kill?(record); false end
  #   def log_parser.suicide?(record); false end
  #   $player_snitch = false
  #   $kill_snitch = false
  #   $suicide_snitch = false
  #   def log_parser.retrieve_player_name(record); $player_snitch=true end
  #   def log_parser.retrieve_kill_info(record); $kill_snitch=true end
  #   def log_parser.retrieve_suicide_info(record); $suicide_snitch=true end
  #   game_collection = log_parser.process(EnumeratorTest.new(['whatever']))
  #   assert_equal(0, game_collection.games.length, 'Expected no game in game collection')
  #   assert_equal([false, false, false], [$player_snitch, $kill_snitch, $suicide_snitch], "No retrieve method should be called")
  # end

  # def test_process_new_game_fork_valid
  #   log_parser = valid_log_parser
  #   def log_parser.new_game?(record); false end
  #   def log_parser.game_end?(record); false end
  #   def log_parser.player?(record); false end
  #   def log_parser.kill?(record); false end
  #   def log_parser.suicide?(record); false end
  #   $player_snitch = false
  #   $kill_snitch = false
  #   $suicide_snitch = false
  #   def log_parser.retrieve_player_name(record); $player_snitch=true end
  #   def log_parser.retrieve_kill_info(record); $kill_snitch=true end
  #   def log_parser.retrieve_suicide_info(record); $suicide_snitch=true end
  #   game_collection = log_parser.process(EnumeratorTest.new(['whatever']))
  #   # assert_equal(0, game_collection.games.length, 'Expected no game in game collection')
  #   # assert_equal(true, $player_snitch, "Method retrieve_player_name should be called")
  #   # assert_equal([false, false], [$kill_snitch, $suicide_snitch], "Only teh retrieve retrieve_player_name method should be called")
  # end


end