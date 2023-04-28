# frozen_string_literal: true

module Jekyll
  module Tasks
    # Verify related API
    module Related
      extend self

      MINIMUM_RELATED_PRODUCTS = 5

      def all_products_with_related(api = api_data)
        errors = []
        Products.model_list.each do |product|
          if api[product]
            count = api[product].count
            errors << "Only has #{count} related products: #{product}" if count < MINIMUM_RELATED_PRODUCTS
          else
            errors << "Doesn't have related products: #{product}"
          end
        end
        errors.empty? ? 'OK' : errors
      end

      def all_related_exist
        errors = []
        models = Products.model_list
        api_data.each do |key, related|
          next unless models.include? key

          errors += related_rules(key, related)
        end
        errors.empty? ? 'OK' : errors
      end

      private

      def related_rules(key, related)
        errors = []
        products = Products.filename_list
        errors << "'#{key}' has duplicate related products" if related.length != related.uniq.length
        related.each do |product|
          errors << "Related '#{product}' (declared @ '#{key}') doesn't exist" unless products.include? product
          errors << "Inception detected @ '#{key}' related product" if inception_detected?(products, product, key)
        end
        errors
      end

      def api_data
        YAML.load_file('./_data/api/yaml/related/products.yml')
      end

      def inception_detected?(filename_list, filename, title)
        filename_list.include?(filename) && Products.title(filename) == title
      end
    end
  end
end
