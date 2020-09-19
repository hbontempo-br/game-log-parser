# frozen_string_literal: true

require_relative 'controllers/quake_log_controller'

require 'sinatra'


class LogParserApp < Sinatra::Application

  use QuakeLogController

end

