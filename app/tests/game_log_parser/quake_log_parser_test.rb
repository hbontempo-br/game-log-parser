# frozen_string_literal: true

require './app/game_log_parser/quake_log_parser'

require 'test/unit'

# QuakeLogParser test class
class QuakeLogParserTest < Test::Unit::TestCase
  # @return [Nil]
  def setup
    @quake_log_parser = QuakeLogParser.new
    super
  end

  # @return [Nil]
  def test_new_game_invalid_record
    # noinspection RubyYardParamTypeMatch
    assert_raise(QuakeLogParser::InvalidRecordTypeQuakeLogParserError) { @quake_log_parser.new_game?(123) }
  end

  # @return [Nil]
  def test_not_a_new_game
    check = @quake_log_parser.new_game?(' 16:53 ------------------------------------------------------------')
    assert_false(check, 'The test record is not an new_game one')
  end

  # @return [Nil]
  def test_valid_new_game
    check = @quake_log_parser.new_game?(' 16:53 InitGame: \capturelimit\8\g_maxGameClients\0\timelimit\15\fraglimit\20\dmflags\0\bot_minplayers\0\sv_allowDownload\0\sv_maxclients\16\sv_privateClients\2\g_gametype\4\sv_hostname\Code Miner Server\sv_minRate\0\sv_maxRate\10000\sv_minPing\0\sv_maxPing\0\sv_floodProtect\1\version\ioq3 1.36 linux-x86_64 Apr 12 2009\protocol\68\mapname\Q3TOURNEY6_CTF\gamename\baseq3\g_needpass\0')
    assert_true(check, 'The test record is an new_game one')
  end

  # @return [Nil]
  def test_game_end_invalid_record
    # noinspection RubyYardParamTypeMatch
    assert_raise(QuakeLogParser::InvalidRecordTypeQuakeLogParserError) { @quake_log_parser.game_end?(123) }
  end

  # @return [Nil]
  def test_not_a_game_end
    check = @quake_log_parser.game_end?(' 16:53 ------------------------------------------------------------')
    assert_false(check, 'The test record is not an game_end one')
  end

  # @return [Nil]
  def test_valid_game_end
    check = @quake_log_parser.game_end?('981:27 ShutdownGame:')
    assert_true(check, 'The test record is an game_end one')
  end

  # @return [Nil]
  def test_kill_invalid_record
    # noinspection RubyYardParamTypeMatch
    assert_raise(QuakeLogParser::InvalidRecordTypeQuakeLogParserError) { @quake_log_parser.kill?(123) }
  end

  # @return [Nil]
  def test_not_a_kill
    check = @quake_log_parser.kill?(' 16:53 ------------------------------------------------------------')
    assert_false(check, 'The test record is not an kill one')
  end

  # @return [Nil]
  def test_valid_kill
    check = @quake_log_parser.kill?('  1:44 Kill: 3 6 7: Oootsimo killed Zeh by MOD_ROCKET_SPLASH')
    assert_true(check, 'The test record is an kill one')
  end

  # @return [Nil]
  def test_suicide_invalid_record
    # noinspection RubyYardParamTypeMatch
    assert_raise(QuakeLogParser::InvalidRecordTypeQuakeLogParserError) { @quake_log_parser.suicide?(123) }
  end

  # @return [Nil]
  def test_not_a_suicide
    check = @quake_log_parser.suicide?(' 16:53 ------------------------------------------------------------')
    assert_false(check, 'The test record is not an suicide one')
  end

  # @return [Nil]
  def test_valid_suicide
    check = @quake_log_parser.suicide?('  0:50 Kill: 1022 5 19: <world> killed Assasinu Credi by MOD_FALLING')
    assert_true(check, 'The test record is an suicide one')
  end

  # @return [Nil]
  def test_player_invalid_record
    # noinspection RubyYardParamTypeMatch
    assert_raise(QuakeLogParser::InvalidRecordTypeQuakeLogParserError) { @quake_log_parser.player?(123) }
  end

  # @return [Nil]
  def test_not_a_player
    check = @quake_log_parser.player?(' 16:53 ------------------------------------------------------------')
    assert_false(check, 'The test record is not an player one')
  end

  # @return [Nil]
  def test_valid_player
    check = @quake_log_parser.player?('  0:00 ClientUserinfoChanged: 2 n\Dono da Bola\t\0\model\sarge\hmodel\sarge\g_redteam\\g_blueteam\\c1\4\c2\5\hc\95\w\0\l\0\tt\0\tl\0')
    assert_true(check, 'The test record is an player one')
  end

  # @return [Nil]
  def test_valid_retrieve_player
    player_name = @quake_log_parser.retrieve_player_name('  0:00 ClientUserinfoChanged: 2 n\Dono da Bola\t\0\model\sarge\hmodel\sarge\g_redteam\\g_blueteam\\c1\4\c2\5\hc\95\w\0\l\0\tt\0\tl\0')
    assert_equal('Dono da Bola', player_name, 'Unexpected player_name retrieved')
  end

  # @return [Nil]
  def test_valid_retrieve_kill_info
    killer, killed, weapon = @quake_log_parser.retrieve_kill_info('  1:44 Kill: 3 6 7: Oootsimo killed Zeh by MOD_ROCKET_SPLASH')
    assert_equal('Oootsimo', killer, 'Unexpected killer retrieved')
    assert_equal('Zeh', killed, 'Unexpected killed retrieved')
    assert_equal('MOD_ROCKET_SPLASH', weapon, 'Unexpected weapon retrieved')
  end

  # @return [Nil]
  def test_valid_retrieve_suicide_info
    player_name, weapon = @quake_log_parser.retrieve_suicide_info('  1:44 Kill: 3 6 7: <world> killed Zeh by MOD_ROCKET_SPLASH')
    assert_equal('Zeh', player_name, 'Unexpected player_name retrieved')
    assert_equal('MOD_ROCKET_SPLASH', weapon, 'Unexpected weapon retrieved')
  end

end
