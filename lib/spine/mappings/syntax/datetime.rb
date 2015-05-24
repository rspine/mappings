module Spine
  module Mappings
    module Syntax
      module DateTime
        def datetime(destination, options = {}, &block)
          command = build(destination, options, &block)
          register(
            destination,
            intercept(command, options) { |value|
              value.to_datetime.iso8601
            }
          )
        end
      end
    end
  end
end
