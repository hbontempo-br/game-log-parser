
require_relative '../game_log_parser/quake_log_parser/quake_log_parser'
require_relative '../game/quake/quake_player'
require_relative '../game/quake/quake_weapon'
require_relative '..//game/quake/quake_kill'
require_relative '..//game/quake/quake_suicide'
require_relative '..//game/quake/quake_game'
require_relative '..//game/game_config'

require 'sinatra'

class QuakeLogController < Sinatra::Base

  # configure :production, :development do
  #   enable :logging
  # end

  post '/quake/upload' do
    # logger.info 'Initiated quake log parsing'
    file = params[:file][:tempfile]
    file_reader = file.open.each_line
    quake_parser = QuakeLogParser.new
    game_collection = quake_parser.process(file_reader)
    file.close
  end
end
