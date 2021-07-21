# frozen_string_literal: true

require 'minitest'

module Jekyll
  module Tasks
    class TasksTest < Minitest::Test
      def test_search_properties_per_collection_with_properties
        result = Menus.search_properties 'collection1', %w[name father]
        assert_equal [
          { 'name' => %w[menu-1 submenu-1] },
          { 'father' => %w[menu-1 submenu-lost] }
        ], result
      end

      def test_search_properties_per_collection_with_a_property
        result = Menus.search_properties 'collection2', ['name']
        assert_equal [{ 'name' => %w[menu-2 submenu-2] }], result
      end

      def test_search_properties_per_collection_on_empty_collection
        result = Menus.search_properties 'data', ['name']
        assert result.empty?
      end

      def test_menus_per_collection
        result = Menus.per_collection
        assert_equal [{
          'collection' => 'collection1',
          'properties' => [{ 'name' => %w[menu-1 submenu-1] }]
        }, {
          'collection' => 'collection2',
          'properties' => [{ 'name' => %w[menu-2 submenu-2] }]
        }], result
      end

      def test_menus_per_collection_with_property
        result = Menus.per_collection ['father']
        assert_equal [{
          'collection' => 'collection1',
          'properties' => [{ 'father' => %w[menu-1 submenu-lost] }]
        }, {
          'collection' => 'collection2',
          'properties' => [{ 'father' => ['menu-2'] }]
        }], result
      end

      def test_menus_per_collection_with_properties
        result = Menus.per_collection %w[name father]
        assert_equal [{
          'collection' => 'collection1',
          'properties' => [{ 'name' => %w[menu-1 submenu-1] }, { 'father' => %w[menu-1 submenu-lost] }]
        }, {
          'collection' => 'collection2',
          'properties' => [{ 'name' => %w[menu-2 submenu-2] }, { 'father' => ['menu-2'] }]
        }], result
      end

      def test_search_conflicts
        result = Menus.search_conflicts
        assert_equal [
          'There are some unused menus at collection1 collection: ["submenu-1"]',
          'There are some products pointed to non-existent menus at collection1 collection: ["submenu-lost"]',
          'There are some unused menus at collection2 collection: ["submenu-2"]'
        ], result
      end

      def test_print_conflicts
        result = Menus.print_conflicts
        assert_equal false, result
      end
    end
  end
end
