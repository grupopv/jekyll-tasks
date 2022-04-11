# frozen_string_literal: true

require 'minitest'

module Jekyll
  module Tasks
    class TasksTest < Minitest::Test
      def test_all_products_with_related
        result = Related.all_products_with_related
        assert_equal [
          'Only has 4 related products: PRODUCT/2',
          "Doesn't have related products: PRODUCT/3"
        ], result
      end

      def test_all_related_products_exist
        result = Related.all_related_exist
        assert_equal [
          "Related 'product-6' (declared @ 'PRODUCT/1') doesn't exist"
        ], result
      end
    end
  end
end
