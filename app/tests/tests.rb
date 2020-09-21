# frozen_string_literal: true

require 'require_all'
require 'simplecov'

SimpleCov.start

if ENV.include? 'CODECOV_TOKEN'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require_all '.'
