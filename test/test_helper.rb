# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

if ENV.fetch('CI', nil) == 'true'
  require 'simplecov-cobertura'
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'jekyll/tasks'

require 'minitest/autorun'
