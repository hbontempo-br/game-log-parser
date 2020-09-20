# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require './app/controllers/quake_log_controller'
require 'test/unit'
require 'rack/test'

# QuakeLogController test class
class QuakeLogControllerTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    QuakeLogController
  end

  def test_post_without_file
    expected_body = '{"message":"Bad request","details":"File is missing"}'

    post '/quake/upload'

    assert_equal('application/json', last_response.headers['content-type'], '/quake/upload without files should return a Content-Type application/json')
    assert_equal(400, last_response.status, '/quake/upload without files should return a BadRequest')
    assert_equal(expected_body, last_response.body, '/quake/upload without files returned and unexpected body')
  end

  def test_post_valid_file
    expected_body = '{"game_1":{"total_kills":0,"players":["Isgalamido"],"kills":{"Isgalamido":0},"rank":{"1":"Isgalamido"},"kills_by_means":{}}}'

    file = Rack::Test::UploadedFile.new(__dir__ + '/test_files/valid.log', 'text/plain')
    post '/quake/upload', {'file' => file}

    assert_equal('application/json', last_response.headers['content-type'], '/quake/upload with files should return a Content-Type application/json')
    assert_equal(200, last_response.status, '/quake/upload with files should return a Ok')
    assert_equal(expected_body, last_response.body, '/quake/upload with files returned and unexpected body')
  end

  def test_post_invalid_file
    expected_body = '{"message":"Bad request","details":"Unable to process provided files"}'

    puts __dir__
    file = Rack::Test::UploadedFile.new(__dir__ + '/test_files/invalid.log', 'text/plain')
    post '/quake/upload', {'file' => file}

    assert_equal('application/json', last_response.headers['content-type'], '/quake/upload with invalid files should return a Content-Type application/json')
    assert_equal(400, last_response.status, '/quake/upload with invalid files should return a BadRequest')
    assert_equal(expected_body, last_response.body, '/quake/upload with invalid files returned and unexpected body')
  end
end
