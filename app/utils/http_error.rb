# frozen_string_literal: true
require 'sinatra/base'
require 'json'

module Sinatra
  module ErrorHandling
    # @param details [String]
    def halt_bad_request(details = nil)
      content_type :json
      status = 400
      body = { message: 'Bad request' }
      body['details'] = details unless details.nil?
      halt status, body.to_json
    end

    # @param details [String]
    def halt_not_found(details = nil)
      content_type :json
      status = 404
      body = { message: 'Not found' }
      body['details'] = details unless details.nil?
      halt status, body.to_json
    end
  end

  helpers ErrorHandling
end
