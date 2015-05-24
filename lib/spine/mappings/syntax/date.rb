module Spine
  module Mappings
    module Syntax
      module Date
        def date(destination, options = {}, &block)
          command = build(destination, options, &block)
          register(
            destination,
            intercept(command, options) {
              |value| value.to_date.iso8601
            }
          )
        end
      end
    end
  end
end
