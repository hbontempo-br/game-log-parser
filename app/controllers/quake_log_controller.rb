# frozen_string_literal: true

require_relative '../game_log_parser/quake_log_parser'
require_relative '../dtos/game_collection_dto'
require_relative '../utils/http_error'

require 'json'

require 'sinatra'

# QuakeLog resource class
class QuakeLogController < Sinatra::Base
  helpers Sinatra::ErrorHandling

  before do
    content_type :json
  end

  post '/quake/upload' do
    halt_bad_request('File is missing') unless params[:file] && params[:file][:tempfile]

    file = params[:file][:tempfile]
    begin
      file_reader = file.open.each_line
      quake_parser = QuakeLogParser.new
      game_collection = quake_parser.process(file_reader)
      game_collection_dto = GameCollectionDTO.new(game_collection)
      response = game_collection_dto.to_hash

      status 200
      body response.to_json
    rescue StandardError
      halt_bad_request('Unable to process provided files')
    ensure
      file&.close
    end
  end
end
