module Spine
  module Mappings
    module Syntax
      module Timestamp
        def timestamp(destination, options = {}, &block)
          command = build(destination, options, &block)
          register(
            destination,
            intercept(command, options) { |value|
              value.to_datetime.iso8601(3)
            }
          )
        end
      end
    end
  end
end
