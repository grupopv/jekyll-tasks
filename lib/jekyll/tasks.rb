# frozen_string_literal: true

require 'yaml'
require 'jekyll/tasks/collections'
require 'jekyll/tasks/dates'
require 'jekyll/tasks/menus'
require 'jekyll/tasks/products'
require 'jekyll/tasks/related'
require 'jekyll/tasks/version'

module Jekyll
  module Tasks
    class Error < StandardError; end
  end
end
