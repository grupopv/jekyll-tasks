# frozen_string_literal: true

module Jekyll
  module Tasks
    # Obtain products information
    module Products
      extend self

      def products_filename_list
        products = []
        products_path_list.each do |product|
          product = product
                    .gsub('./_data/api/hana/products/', '')
                    .gsub('.yml', '')
          products << product
        end
        products
      end

      def products_model_list
        products = []
        products_path_list.each do |product|
          data = YAML.load_file(product)
          products << data['title']
        end
        products
      end

      private

      def products_path_list
        Dir.glob('./_data/api/hana/products/*.yml').to_a.sort
      end
    end
  end
end
