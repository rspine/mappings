module Spine
  module Mappings
    module Commands
      class Fetch
        attr_reader :method_name

        def initialize(method_name)
          @method_name = method_name
        end

        def execute(source)
          if source.respond_to?(method_name)
            source.public_send(method_name)
          elsif source.respond_to?('[]')
            source[method_name]
          else
            raise "Source object don't have #{ method_name } method defined."
          end
        end
      end
    end
  end
end
