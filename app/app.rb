# frozen_string_literal: true
require_relative 'controllers/quake_log_controller'
require_relative 'utils/http_error'

require 'sinatra'

# App class
class LogParserApp < Sinatra::Application
  helpers Sinatra::ErrorHandling

  use QuakeLogController

  not_found do
    halt_not_found('Resource not found')
  end

end

