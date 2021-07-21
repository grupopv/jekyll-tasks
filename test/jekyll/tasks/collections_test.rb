# frozen_string_literal: true

require 'minitest'

module Jekyll
  module Tasks
    class TasksTest < Minitest::Test
      def test_list_collections
        result = Collections.get
        assert_equal %w[collection1 collection2 data], result
      end
    end
  end
end
