# frozen_string_literal: true

require 'minitest'
require 'yaml'

module Jekyll
  module Tasks
    class TasksTest < Minitest::Test
      def test_the_products_model_list
        products = Products.products_model_list
        assert_equal ['PRODUCT/1', 'PRODUCT/2', 'PRODUCT/3'], products
      end

      def test_the_products_filename_list
        products = Products.products_filename_list
        assert_equal %w[product-1 product-2 product-3], products
      end
    end
  end
end
