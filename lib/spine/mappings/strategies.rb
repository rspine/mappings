module Spine
  module Mappings
    module Strategies
      extend self

      autoload :Strict, 'spine/mappings/strategies/strict'
      autoload :Compact, 'spine/mappings/strategies/compact'

      def collection
        @collection ||= default_collection
      end

      def find(identifier)
        collection[identifier] || collection[default_identifier]
      end

      private

      def default_identifier
        :strict
      end

      def default_collection
        { strict: Strict, compact: Compact }
      end
    end
  end
end
