# frozen_string_literal: true

module Jekyll
  module Tasks
    # Obtain products information
    module Products
      extend self

      PRODUCTS_PATH = './_data/api/hana/products/'
      EXTENSION     = '.yml'

      def filename_list
        products = []
        path_list.each do |product|
          product = product
                    .gsub(PRODUCTS_PATH, '')
                    .gsub(EXTENSION, '')
          products << product
        end
        products
      end

      def model_list
        products = []
        path_list.each do |product|
          data = YAML.load_file(product)
          products << data['title']
        end
        products
      end

      def product_without_father?(data)
        data['layout'].nil? && data['menu-father'].nil?
      end

      def title(product)
        data = YAML.load_file("#{PRODUCTS_PATH}#{product}#{EXTENSION}")
        data['title']
      end

      private

      def path_list
        Dir.glob("#{PRODUCTS_PATH}*#{EXTENSION}").to_a.sort
      end
    end
  end
end
