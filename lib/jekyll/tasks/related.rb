# frozen_string_literal: true

module Jekyll
  module Tasks
    # Verify related API
    module Related
      extend self

      MINIMUM_RELATED_PRODUCTS = 5

      def all_products_with_related
        errors = []
        api = api_data
        Products.model_list.each do |product|
          if api[product]
            count = api[product].count
            errors << "Only has #{count} related products: #{product}" if count < MINIMUM_RELATED_PRODUCTS
          else errors << "Doesn't have related products: #{product}"
          end
        end
        errors.empty? ? 'OK' : errors
      end

      def all_related_exist
        errors = []
        products = Products.filename_list
        api_data.each do |key, related|
          related.each do |product|
            errors << "Related '#{product}' (declared @ '#{key}') doesn't exist" unless products.include? product
          end
        end
        errors.empty? ? 'OK' : errors
      end

      private

      def api_data
        YAML.load_file('./_data/api/yaml/related/products.yml')
      end
    end
  end
end
