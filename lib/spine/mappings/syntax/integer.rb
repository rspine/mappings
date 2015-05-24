module Spine
  module Mappings
    module Syntax
      module Integer
        def integer(destination, options = {}, &block)
          command = build(destination, options, &block)
          register(
            destination,
            intercept(command, options) { |value| value.to_i }
          )
        end
      end
    end
  end
end
