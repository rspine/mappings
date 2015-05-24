module Spine
  module Mappings
    module Syntax
      module Nested
        def nested(destination, options = {}, &block)
          mapping = repository.parse(block)
          mapper = Mapper.new([mapping])
          command = build(destination, options)
          register(
            destination,
            intercept(command, options) { |value| mapper.map(value, options) }
          )
        end
      end
    end
  end
end
