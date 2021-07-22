# frozen_string_literal: true

module Jekyll
  module Tasks
    # Obtain products information
    module Products
      extend self

      def filename_list
        products = []
        path_list.each do |product|
          product = product
                    .gsub('./_data/api/hana/products/', '')
                    .gsub('.yml', '')
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

      def product_without_father(data)
        data['layout'].nil? && data['menu-father'].nil?
      end

      private

      def path_list
        Dir.glob('./_data/api/hana/products/*.yml').to_a.sort
      end
    end
  end
end
