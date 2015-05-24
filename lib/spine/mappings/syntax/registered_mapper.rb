module Spine
  module Mappings
    module Syntax
      module RegisteredMapper
        def method_missing(name, *arguments, &block)
          mapper = repository.find(name.to_sym)
          super and return unless mapper

          destination = arguments.shift
          options = arguments.shift || {}
          command = build(destination, options, &block)
          register(
            destination,
            intercept(command, options) { |value| mapper.map(value) }
          )
        end
      end
    end
  end
end
