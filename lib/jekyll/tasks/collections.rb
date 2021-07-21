# frozen_string_literal: true

module Jekyll
  module Tasks
    # Obtain collections information
    module Collections
      extend self

      def get
        collections = []
        folders_starting_with_underscore.each do |collection|
          collections << collection[3..]
        end
        collections
      end

      private

      def folders_starting_with_underscore
        Dir.glob('./_*').to_a.sort
      end
    end
  end
end
