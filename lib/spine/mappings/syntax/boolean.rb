module Spine
  module Mappings
    module Syntax
      module Boolean
        def boolean(destination, options = {}, &block)
          command = build(destination, options, &block)
          register(
            destination,
            intercept(command, options) { |value| !!value }
          )
        end
      end
    end
  end
end
