# frozen_string_literal: true

module Jekyll
  module Tasks
    # Obtain collections information
    module Collections
      extend self

      def get
        folders_starting_with_underscore.map do |collection|
          collection[3..]
        end
      end

      private

      def folders_starting_with_underscore
        Dir.glob('./_*').to_a.sort
      end
    end
  end
end
