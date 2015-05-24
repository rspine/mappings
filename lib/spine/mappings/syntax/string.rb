module Spine
  module Mappings
    module Syntax
      module String
        def string(destination, options = {}, &block)
          command = build(destination, options, &block)
          register(
            destination,
            intercept(command, options) { |value| value.to_s }
          )
        end
      end
    end
  end
end
