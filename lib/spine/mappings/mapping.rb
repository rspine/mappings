module Spine
  module Mappings
    class Mapping
      include Syntax::Any
      include Syntax::String
      include Syntax::Integer
      include Syntax::Decimal
      include Syntax::Boolean
      include Syntax::Date
      include Syntax::DateTime
      include Syntax::Timestamp
      include Syntax::Nested
      include Syntax::Collection
      include Syntax::RegisteredMapper

      attr_reader :commands, :repository

      def initialize(repository)
        @repository = repository
        @commands = {}
      end

      private

      def register(destination, command)
        @commands[destination] = command
      end

      def intercept(command, options, &block)
        Commands::Intercept.new(command, block, options)
      end

      def build(destination, options, &block)
        return Commands::ActionFetch.new(block) if block_given?

        Commands::Fetch.new(options.fetch(:from, destination))
      end
    end
  end
end
