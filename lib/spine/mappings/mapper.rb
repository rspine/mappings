module Spine
  module Mappings
    class Mapper
      attr_reader :mappings

      def initialize(mappings)
        @mappings = mappings
      end

      def map(source, options = {})
        return nil unless source

        strategy = Strategies.find(options[:strategy])
        mappings.reduce({}) do |mapped, mapping|
          strategy.run(mapping.commands, source, mapped)
        end
      end

      def map_all(sources, options = {})
        return nil unless sources || sources.empty?

        sources.map { |source| map(source, options) }
      end
    end
  end
end
