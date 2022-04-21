# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

if ENV.fetch('CI', nil) == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'jekyll/tasks'

require 'minitest/autorun'
