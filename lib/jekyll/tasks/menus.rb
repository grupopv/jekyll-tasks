# frozen_string_literal: true

module Jekyll
  module Tasks
    # Obtain menus information
    module Menus
      extend self

      def search_conflicts
        conflicts = []
        conflicts << (search_conflicts_with_properties | search_conflicts_without_properties)
        conflicts.flatten!
      end

      def search_conflicts_with_properties
        conflicts = []

        per_collection(%w[name father]).each do |el|
          properties = el['properties']

          index = search_hash(properties, 'name')
          name = index.nil? ? '' : properties[index]['name']

          index = search_hash(properties, 'father')
          father = index.nil? ? '' : properties[index]['father']

          conflicts << analyze_conflicts(el['collection'], name, father) if name != father
        end

        conflicts
      end

      def search_conflicts_without_properties
        conflicts = []

        Collections.get.each do |collection|
          data = search_without_properties(collection) unless collection == 'pages'
          conflicts << data unless data.nil?
        end

        conflicts
      end

      def per_collection(properties = ['name'])
        result = []
        Collections.get.each do |collection|
          data = search_properties(collection, properties)
          hash = { 'collection' => collection, 'properties' => data }
          result << hash unless data.empty?
        end
        result
      end

      def search_without_properties(collection)
        conflicts = []

        files = markdown_files collection
        files.each do |file|
          data = YAML.load_file(file)
          conflicts << analyze_conflicts_without_properties(data)
        end

        conflicts
      end

      def search_properties(collection, properties, result = [])
        files = markdown_files collection
        files.each do |file|
          data = YAML.load_file(file)
          properties.each do |property|
            search_property result, data, property
          end
        end
        order_properties(result, properties)
      end

      private

      def analyze_conflicts_without_properties(data, conflicts = [])
        conflicts << "Product without father: '#{data['title']}'" if Products.product_without_father? data
        conflicts << "Menu without name: '#{data['title']}'" if menu_without_name? data
        conflicts << "Menu without father: '#{data['title']}'" if menu_without_father? data
        conflicts
      end

      def menu_without_name?(data)
        data['layout'] == 'grid' && data['menu-name'].nil?
      end

      def menu_without_father?(data)
        data['layout'] == 'grid' && data['menu-father'].nil? && data['permalink'].nil?
      end

      def analyze_conflicts(collection, name, father, conflicts = [])
        array = name - father
        conflicts << "There are some unused menus at #{collection} collection: #{array}" unless array.empty?

        array = father - name
        unless array.empty?
          conflicts << "There are some products pointed to non-existent menus at #{collection} collection: #{array}"
        end

        conflicts
      end

      def search_property(result, data, property)
        value = data["menu-#{property}"]
        index = search_hash(result, property)

        (result[index][property] << value unless value.nil?) if index
        (result << { property => value.nil? ? [] : [value] }) unless index
      end

      def order_properties(result, properties)
        properties.each do |property|
          index = search_hash(result, property)
          result[index][property] = result[index][property].sort.uniq unless index.nil?
        end
        result
      end

      def search_hash(list, property)
        list.each_with_index do |hash, index|
          return index if hash[property]
        end
        nil
      end

      def markdown_files(colecction)
        Dir.glob("./_#{colecction}/**/*.md").to_a.sort
      end
    end
  end
end
