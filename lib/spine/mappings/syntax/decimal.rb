module Spine
  module Mappings
    module Syntax
      module Decimal
        def decimal(destination, options = {}, &block)
          command = build(destination, options, &block)
          register(
            destination,
            intercept(command, options) { |value| value.to_f }
          )
        end
      end
    end
  end
end
