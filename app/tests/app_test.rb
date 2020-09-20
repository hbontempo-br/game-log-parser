# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require './app/app'
require 'test/unit'
require 'rack/test'

# LogParserApp test class
class LogParserAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    LogParserApp
  end

  def test_invalid_endpoint
    expected_body = '{"message":"Not found","details":"Resource not found"}'

    post '/invalid_endpoint'

    assert_equal('application/json', last_response.headers['content-type'], '/quake/upload without files should return a Content-Type application/json')
    assert_equal(404, last_response.status, '/quake/upload without files should return a BadRequest')
    assert_equal(expected_body, last_response.body, '/quake/upload without files returned and unexpected body')
  end
end
